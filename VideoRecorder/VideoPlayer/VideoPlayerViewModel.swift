//
//  VideoPlayerViewModel.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine
import AVKit

class VideoPlayerViewModel {
    // MARK: Input
    enum Action {
        case toggleToolsVisibility
        case rewind
        case setIsPlaying(Bool)
        case setIsEditingCurrentTime(Bool)
        case seekTime(Double)
    }
    
    // MARK: Output
    @Published var player: AVPlayer = AVPlayer()
    @Published var toolsIsHidden = false
    @Published var metaData: VideoMetaData
    @Published var currentTime: Double = 0
    @Published var isEditingCurrentTime: Bool = false
    
    // MARK: Properties
    var action = PassthroughSubject<Action, Never>()
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(metaData: VideoMetaData) {
        self.metaData = metaData
        action
            .sink(receiveValue: { [weak self] action in
                guard let self else { return }
                self.mutate(action: action)
            })
            .store(in: &subscriptions)
        bind()
    }
    
    // MARK: Mutate
    func mutate(action: Action) {
        switch action {
        case .toggleToolsVisibility:
            toolsIsHidden.toggle()
        case .rewind:
            player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
            self.currentTime = .zero
        case .setIsPlaying(let shouldPlay):
            if shouldPlay {
                player.play()
            } else {
                player.pause()
            }
        case .setIsEditingCurrentTime(let isEditing):
            if isEditingCurrentTime != isEditing {
                isEditingCurrentTime = isEditing
            }
        case .seekTime(let time):
            self.player.seek(to: CMTime(seconds: time, preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .zero)
        }
    }
    
    // MARK: Bind
    func bind() {
        $metaData
            .compactMap { $0.videoPath }
            .flatMap { FirebaseManager.shared.getVideoIfNeeded($0) }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] url in
                guard let self else { return }
                let item = AVPlayerItem(url: url)
                self.player.replaceCurrentItem(with: item)
                self.player.play()
            }).store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .map { _ in Action.setIsPlaying(false) }
            .subscribe(action)
            .store(in: &subscriptions)
        
        Timer.publish(every: 1 / 600, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] timer in
                guard
                    let self,
                    !self.isEditingCurrentTime,
                    self.player.currentItem != nil
                else { return }
                self.currentTime = self.player.currentTime().seconds
            }.store(in: &subscriptions)
    }
}

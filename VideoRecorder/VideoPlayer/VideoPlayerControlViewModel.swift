//
//  VideoPlayerControlViewModel.swift
//  VideoRecorder
//
//  Created by 한경수 on 2022/10/13.
//

import Foundation
import UIKit
import Combine

class VideoPlayerControlViewModel {
    // MARK: Input
    enum Action {
        case toggleIsPlaying
        case setIsPlaying(Bool)
        case setCurrentTime(Double)
        case setCurrentTimeWithProgress(Double)
        case setDuration(Double)
        case setIsEditingCurrentTime(Bool)
    }
    
    // MARK: Output
    @Published var isPlaying: Bool = false
    @Published var currentTime: Double = 63
    @Published var duration: Double = 221
    @Published var isEditingCurrentTime: Bool = false
    
    // MARK: Properties
    var action = PassthroughSubject<Action, Never>()
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        action
            .sink(receiveValue: { [weak self] action in
                guard let self else { return }
                self.mutate(action: action)
            })
            .store(in: &subscriptions)
    }
    
    // MARK: Mutate
    func mutate(action: Action) {
        switch action {
        case .toggleIsPlaying:
            isPlaying.toggle()
        case .setIsPlaying(let isPlaying):
            if self.isPlaying != isPlaying {
                self.isPlaying = isPlaying
            }
        case .setCurrentTime(let time):
            if currentTime != time {
                currentTime = time
            }
        case .setCurrentTimeWithProgress(let progress):
            let currentTime = progress * duration
            if self.currentTime != currentTime {
                self.currentTime = currentTime
            }
        case .setDuration(let time):
            if duration != time {
                duration = time
            }
        case .setIsEditingCurrentTime(let isEditing):
            if isEditingCurrentTime != isEditing {
                isEditingCurrentTime = isEditing
            }
        }
    }
}

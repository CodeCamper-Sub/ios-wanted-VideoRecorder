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
    }
    
    // MARK: Output
    @Published var isPlaying: Bool = false
    @Published var currentTime: Int = 63
    @Published var duration: Int = 221
    
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
        }
    }
}

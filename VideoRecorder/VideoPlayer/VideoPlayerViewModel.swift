//
//  VideoPlayerViewModel.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine


class VideoPlayerViewModel {
    // MARK: Input
    enum Action {
        case toggleToolsVisibility
    }
    
    // MARK: Output
    @Published var toolsIsHidden = false
    
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
        case .toggleToolsVisibility:
            toolsIsHidden.toggle()
        }
    }
}

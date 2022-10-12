//
//  VideoPlayerViewControllerViewController.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine

// MARK: - View Controller
class VideoPlayerViewController: UIViewController {
    // MARK: View Components
    
    
    // MARK: Associated Types
    typealias ViewModel = VideoPlayerViewModel
    
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel = ViewModel()
    @Published var controlViewIsHidden = false
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buildViewHierarchy()
        self.view.setNeedsUpdateConstraints()
        bind()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    // MARK: Setup Views
    func setupViews() {
        
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        
    }
    
    
    // MARK: Binding
    func bind() {
        
    }
}

//
//  VideoPlayerViewControllerViewController.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View Controller
class VideoPlayerViewController: UIViewController {
    // MARK: View Components
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var controlView: VideoPlayerControlView = {
        let viewModel = VideoPlayerControlViewModel()
        let view = VideoPlayerControlView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .black
        label.text = "Nature.mp4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Associated Types
    typealias ViewModel = VideoPlayerViewModel
    
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel = ViewModel()
    var subscriptions = [AnyCancellable]()
    
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: Setup Views
    func setupViews() {
        self.view.backgroundColor = .gray
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.view.addSubview(navigationView)
        self.view.addSubview(controlView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(titleLabel)
        navigationView.addSubview(infoButton)
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            navigationView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
        ]
        
        constraints += [
            backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -12),
            backButton.widthAnchor.constraint(equalToConstant: 12),
            backButton.heightAnchor.constraint(equalToConstant: 19),
        ]
        
        constraints += [
            titleLabel.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 53),
            titleLabel.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -9),
        ]
        
        constraints += [
            infoButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -26),
            infoButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -12),
            infoButton.widthAnchor.constraint(equalToConstant: 19),
            infoButton.heightAnchor.constraint(equalToConstant: 19),
        ]
        
        constraints += [
            controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -21),
            controlView.heightAnchor.constraint(equalToConstant: 148),
            controlView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
        ]
    }
    
    
    // MARK: Binding
    func bind() {
        // Action
        self.view.gesture(.tap)
            .map { _ in ViewModel.Action.toggleToolsVisibility }
            .subscribe(viewModel.action)
            .store(in: &subscriptions)
        
        // State
        viewModel.$toolsIsHidden
            .sink { [weak self] isHidden in
                guard let self else { return }
                UIView.animate(withDuration: 0.2) {
                    self.controlView.alpha = isHidden ? 0 : 1
                    self.navigationView.alpha = isHidden ? 0 : 1
                }
            }.store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct ContentViewControllerPreview<View: UIViewController> : UIViewControllerRepresentable {
    
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
struct VideoPlayerViewControllerPreviewProvider: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let viewController = VideoPlayerViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            return navigationController
        }
    }
}
#endif

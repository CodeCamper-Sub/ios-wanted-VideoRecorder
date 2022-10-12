//
//  SliderView.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class SliderView: UIView {
    // MARK: View Components
    lazy var backgroundView: ObservableView = {
        let view = ObservableView()
        view.backgroundColor = UIColor(hex: "#7E8080")
        view.layer.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var foregroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D9D9D9")
        view.layer.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var foregroundViewWidthAnchor: NSLayoutConstraint!
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.45
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Associated Types
    typealias ViewModel = SliderViewModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        buildViewHierarchy()
        self.setNeedsUpdateConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    // MARK: Setup Views
    func setupViews() {
        
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        addSubview(backgroundView)
        addSubview(foregroundView)
        addSubview(circleView)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer {
            NSLayoutConstraint.activate(constraints)
        }
        
        constraints += [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 3),
        ]
        
        foregroundViewWidthAnchor = foregroundView.widthAnchor.constraint(equalToConstant: 200)
        constraints += [
            foregroundView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            foregroundView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            foregroundViewWidthAnchor,
            foregroundView.heightAnchor.constraint(equalToConstant: 3),
        ]
        
        constraints += [
            circleView.centerYAnchor.constraint(equalTo: foregroundView.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: foregroundView.trailingAnchor, constant: 3.5),
            circleView.widthAnchor.constraint(equalToConstant: 7),
            circleView.heightAnchor.constraint(equalToConstant: 7),
        ]
    }
    
    
    // MARK: Binding
    func bind() {
        // Action
        self.gesture(.pan)
            .merge(with: self.gesture(.tap))
            .map { $0.location(in: self).x }
            .map { $0 / self.frame.width }
            .map { ViewModel.Action.updateProgress($0) }
            .subscribe(viewModel.action)
            .store(in: &subscriptions)
        
        // State
        viewModel.$progress
            .map { CGFloat($0) }
            .combineLatest(backgroundView.$framePublisher)
            .sink { [weak self] multiplier, frame in
                guard let self else { return }
                self.foregroundViewWidthAnchor?.constant = frame.width * multiplier
            }
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct ContentViewPreview<View: UIView> : UIViewRepresentable {
    
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> some UIView {
        view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
struct SliderViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SliderView(viewModel: SliderViewModel())
            return view
        }.previewLayout(.fixed(width: 390, height: 80))
            .background(Color.black .opacity(0.5))
    }
}
#endif

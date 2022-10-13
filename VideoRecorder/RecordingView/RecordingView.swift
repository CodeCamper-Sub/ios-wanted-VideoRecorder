//
//  RecordingView.swift
//  VideoRecorder
//
//  Created by KangMingyo on 2022/10/11.
//

import UIKit

class RecordingView: UIView {
    
    let cencelButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cameraSetView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thumbnailButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "image"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let recordingButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let rotateButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [recordingButton, timeLabel].forEach {
            self.recordStackView.addArrangedSubview($0)
        }
        
        addView()
        configure()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addSubview(cencelButton)
        addSubview(cameraSetView)
        cameraSetView.addSubview(thumbnailButton)
//        cameraSetView.addSubview(recordingButton)
//        cameraSetView.addSubview(timeLabel)
        cameraSetView.addSubview(recordStackView)
        cameraSetView.addSubview(rotateButton)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            cencelButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            cencelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            cameraSetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cameraSetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cameraSetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            cameraSetView.widthAnchor.constraint(equalToConstant: 300),
            cameraSetView.heightAnchor.constraint(equalToConstant: 100),
            
            thumbnailButton.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
            thumbnailButton.leadingAnchor.constraint(equalTo: cameraSetView.leadingAnchor, constant: 20),
            thumbnailButton.widthAnchor.constraint(equalToConstant: 50),
            thumbnailButton.heightAnchor.constraint(equalToConstant: 50),
            
            recordStackView.centerXAnchor.constraint(equalTo: cameraSetView.centerXAnchor),
            recordStackView.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
//            recordingButton.centerXAnchor.constraint(equalTo: cameraSetView.centerXAnchor),
//            recordingButton.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
//
//            timeLabel.topAnchor.constraint(equalTo: recordingButton.bottomAnchor, constant: 10),
            
            rotateButton.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
            rotateButton.trailingAnchor.constraint(equalTo: cameraSetView.trailingAnchor, constant: -20)
            
        ])
    }

}

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
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recordingButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rotateButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        configure()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addSubview(cencelButton)
        addSubview(cameraSetView)
        cameraSetView.addSubview(thumbnailImageView)
        cameraSetView.addSubview(recordingButton)
        cameraSetView.addSubview(timeLabel)
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
            
            thumbnailImageView.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: cameraSetView.leadingAnchor, constant: 20),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 50),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 50),

            recordingButton.centerXAnchor.constraint(equalTo: cameraSetView.centerXAnchor),
            recordingButton.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
            
            rotateButton.centerYAnchor.constraint(equalTo: cameraSetView.centerYAnchor),
            rotateButton.trailingAnchor.constraint(equalTo: cameraSetView.trailingAnchor, constant: -20)
            
            
            
            
        ])
    }

}

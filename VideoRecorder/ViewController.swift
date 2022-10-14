//
//  ViewController.swift
//  VideoRecorder
//
//  Created by kjs on 2022/10/07.
//

import UIKit

class ViewController: UIViewController {
    
    let titleView: CustomTitleView = {
       let view = CustomTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let videoListView: VideoListView = {
        let view = VideoListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        titleView.recodeButton.addTarget(self, action: #selector(recodeButtonPressed), for: .touchUpInside)
        
        addSubView()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videoListView.videoListTableView.reloadData()
    }
    
    @objc func recodeButtonPressed() {
        let nextVC = RecordingViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: false)
    }
    
    func addSubView() {
        view.addSubview(titleView)
        view.addSubview(videoListView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 100),

            videoListView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            videoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

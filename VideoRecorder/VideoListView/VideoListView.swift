//
//  VideoListView.swift
//  VideoRecorder
//
//  Created by KangMingyo on 2022/10/11.
//

import UIKit

class VideoListView: UIView {
    
    let videoListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        
        addView()
        configure()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        videoListTableView.register(VideoListTableViewCell.self, forCellReuseIdentifier: "cell")
     }
    
    func addView() {
        addSubview(videoListTableView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
        videoListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        videoListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        videoListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        videoListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension VideoListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoListTableViewCell
        cell.thumbnailImageView.image = UIImage(named: "image")
        cell.videoNameLabel.text = "Nature.mp4"
        cell.dateLabel.text = "2022-10-11"
        return cell
    }

}

//
//  VideoListView.swift
//  VideoRecorder
//
//  Created by KangMingyo on 2022/10/11.
//

import UIKit

class VideoListView: UIView {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "ko_kr")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()
    
    let videoListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadData()
        
        setupTableView()
        
        addView()
        configure()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        var resultMetaData: VideoMetaData?
        VideoManager.shared.loadVideos(start: 6) { result in
            print("result: \(String(describing: result))")
            switch result {
            case .success(let metaDatas):
                resultMetaData = metaDatas.first
                print("result: \(String(describing: resultMetaData))")
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        return String(format: "%.2d:%.2d", minutes, seconds)
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
        return CoreDataManager.shared.videoMataData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoListTableViewCell
        let data = CoreDataManager.shared.videoMataData[indexPath.row]
        cell.thumbnailImageView.image = UIImage(data: data.thumbnail!)
        cell.timelabel.text = timeString(from: data.videoLength)
        cell.videoNameLabel.text = data.name
        cell.dateLabel.text = formatter.string(for: data.createdAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let data = CoreDataManager.shared.videoMataData[indexPath.row]
            var resultMetaData: VideoMetaData?
            VideoManager.shared.saveVideo(name: "Test", path: data.videoPath!) { result in
                print("여기 \(result)")
                switch result {
                case .success(let metaData):
                    resultMetaData = metaData
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            CoreDataManager.shared.videoMataData.remove(at: indexPath.row)
            videoListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


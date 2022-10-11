//
//  VideoManager.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/11.
//

import Foundation

protocol VideoManagerProtocol {
    /// 녹화한 영상이 저장될 경로를 요청합니다.
    /// - Returns: 녹화한 영상이 저장될 경로를 반환합니다. 에러가 발생하는 경우 nil을 리턴합니다.
    func getVideoURL() -> URL?
    
    
    /// 녹화한 영상의 저장을 요청합니다.
    /// - Parameters:
    ///   - name: 영상의 이름
    ///   - path: 영상이 저장되는 경로, getVideoURL() 메소드를 통해 얻을 수 있습니다.
    ///   - completion: 저장이 완료된 뒤, 실행되는 completion입니다. 저장된 영상의 MetaData가 반환됩니다.
    func saveVideo(name: String, path: URL, completion: @escaping (Result<VideoMetaData, VideoManagerError>) -> ())
    
    /// 저장된 영상들의 목록을 요청합니다.
    /// - Parameters:
    ///   - start: 영상 목록의 시작 Index입니다. 이 Index로부터 최대 6개의 영상을 반환합니다.
    ///   - completion: 영상 읽어오기가 완료된 뒤, 실행되는 completion. 불러온 영상들의 MetaData가 반환됩니다.
    func loadVideos(start: Int, completion: @escaping (Result<[VideoMetaData], VideoManagerError>) -> ())
    
    /// 지정된 경로의 영상의 삭제를 요청합니다.
    /// - Parameters:
    ///   - path: 삭제할 영상의 path입니다.
    ///   - completion: 영상의 삭제가 완료된 뒤, 실행되는 completion입니다. 삭제한 영상의 MetaData가 반환됩니다.
    func deleteVideo(path: URL, completion: @escaping (Result<VideoMetaData, VideoManagerError>) -> ())
}

extension VideoManagerProtocol {
    func getVideoURL() -> URL? {
        // TODO...
        return nil
    }
}

class VideoManager: VideoManagerProtocol {
    // MARK: Singleton
    let shared = VideoManager()
    
    private init() { }
    
    
    func saveVideo(name: String, path: URL, completion: @escaping (Result<VideoMetaData, VideoManagerError>) -> ()) {
        // TODO...
    }
    
    func loadVideos(start: Int, completion: @escaping (Result<[VideoMetaData], VideoManagerError>) -> ()) {
        // TODO...
    }
    
    func deleteVideo(path: URL, completion: @escaping (Result<VideoMetaData, VideoManagerError>) -> ()) {
        // TODO...
    }
}

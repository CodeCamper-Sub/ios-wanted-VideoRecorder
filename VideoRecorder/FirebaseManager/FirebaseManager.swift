//
//  FirebaseManager.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import FirebaseStorage

protocol FirebaseManagerProtocol {
    func uploadVideo(_ url: URL)
    func deleteVideo(_ url: URL)
    func getVideo(_ url: URL, completion: @escaping (Result<URL, Error>) -> ())
}

class FirebaseManager: FirebaseManagerProtocol {
    // MARK: Singleton
    static let shared = FirebaseManager()
    private init() { }
    
    // MARK: Properties
    lazy var storage = Storage.storage()
    
    // MARK: Implementations
    func uploadVideo(_ url: URL) {
        DispatchQueue.global().async {
            let fileRef = self.storage.reference().child(url.lastPathComponent)
            fileRef.putFile(from: url, completion: { _, error in
                if let error = error {
                    debugPrint("😡Firebase Upload Error Occured!😡: \(error)")
                }
            })
        }
    }
    
    func deleteVideo(_ url: URL) {
        DispatchQueue.global().async {
            let fileRef = self.storage.reference().child(url.lastPathComponent)
            fileRef.delete(completion: { error in
                if let error = error {
                    debugPrint("😡Firebase Delete Error Occured!😡: \(error)")
                }
            })
        }
    }
    
    func getVideo(_ url: URL, completion: @escaping (Result<URL, Error>) -> ()) {
        DispatchQueue.global().async {
            let fileRef = self.storage.reference().child(url.lastPathComponent)
            fileRef.write(toFile: url, completion: { url, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else if let url = url {
                    DispatchQueue.main.async {
                        completion(.success(url))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(FirebaseManagerError.loadError))
                    }
                }
            })
        }
    }
}




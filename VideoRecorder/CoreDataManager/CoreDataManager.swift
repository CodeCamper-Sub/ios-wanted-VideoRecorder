//
//  CoreDataManager.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/11.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }
    
    func fetchVideoMetaData(start: Int) throws -> [VideoMetaData]
    func createNewVideoMetaData(name: String, createdAt: Date, videoPath: URL, thumbnail: Data, videoLength: Double) throws -> VideoMetaData
    func insertVideoMetaData(_ data: VideoMetaData) throws
    func deleteVideoMetaData(_ data: VideoMetaData) throws
}


class CoreDataManager: CoreDataManagerProtocol {
    // MARK: Singleton
    static let shared = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetchVideoMetaData(start: Int) throws -> [VideoMetaData] {
        let request = VideoMetaData.fetchRequest()
        request.fetchLimit = 6
        request.fetchOffset = start
        let result = try self.context.fetch(request)
        return result
    }
    
    func createNewVideoMetaData(name: String, createdAt: Date, videoPath: URL, thumbnail: Data, videoLength: Double) throws -> VideoMetaData {
        guard let entity = NSEntityDescription.entity(forEntityName: VideoMetaData.className, in: self.context) else { throw CoreDataManagerError.entityError }
        let metaData = VideoMetaData(entity: entity, insertInto: self.context)
        metaData.name = name
        metaData.createdAt = createdAt
        metaData.videoPath = videoPath
        metaData.thumbnail = thumbnail
        metaData.videoLength = videoLength
        return metaData
    }
    
    func insertVideoMetaData(_ data: VideoMetaData) throws {
        try self.context.save()
    }
    
    func deleteVideoMetaData(_ data: VideoMetaData) throws {
        self.context.delete(data)
        try self.context.save()
    }
}

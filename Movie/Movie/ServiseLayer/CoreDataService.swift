// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

final class CoreDataService {
    // MARK: - Init

    static let shared = CoreDataService()
    private init() {}

    // MARK: - Core Data

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            print("storeDescription = \(storeDescription)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

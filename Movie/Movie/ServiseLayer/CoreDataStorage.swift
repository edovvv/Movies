// CoreDataStorage.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

final class CoreDataStorage {
    let coreDataService = CoreDataService.shared

    func save(films: [Results]) {
        for element in films {
            let movie = MoviesManagedObject(context: coreDataService.context)
            movie.id = element.id ?? 0
            movie.title = element.title
            movie.overview = element.overview
            movie.posterPath = element.posterPath
            movie.releaseDate = element.releaseDate
            movie.voteAverage = element.voteAverage ?? 0.0
            coreDataService.saveContext()
        }
    }

    func getObects() -> [MoviesManagedObject] {
        let entityName = String(describing: MoviesManagedObject.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let fetchObject = try? coreDataService.context.fetch(fetchRequest) as? [MoviesManagedObject]
        return fetchObject ?? []
    }
}

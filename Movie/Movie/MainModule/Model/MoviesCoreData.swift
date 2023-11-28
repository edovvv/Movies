// MoviesCoreData.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

@objc(MoviesManagedObject)

final class MoviesManagedObject: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var title: String?
    @NSManaged var overview: String?
    @NSManaged var voteAverage: Double
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: String?
}

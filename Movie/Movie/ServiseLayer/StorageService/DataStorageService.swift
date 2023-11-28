// DataStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DataStorageServiceProtocol {
    func save(object: Results)
    func get() -> Results
}

final class DataStorageService: DataStorageServiceProtocol {
    private let repository = Repository(dataBase: RealmMovies())

    func save(object: Results) {
        repository.save(obj: object)
    }

    func get() -> Results {
        repository.getMovie()
    }
}

// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// структура
struct Movies: Decodable {
    let results: [Results]
}

/// структура
struct Results: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

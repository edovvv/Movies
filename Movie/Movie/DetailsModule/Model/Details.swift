// Details.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// struct for Details
struct Details: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

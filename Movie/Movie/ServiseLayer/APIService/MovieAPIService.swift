// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func getMovies(complition: @escaping (Result<Movies, Error>) -> Void)
    func getDetails(id: Int, complition: @escaping (Result<Details?, Error>) -> Void)
}

final class MovieAPIService: NetworkServiceProtocol {
    func getMovies(complition: @escaping (Result<Movies, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=1ee34276a75d38c0cae118c698cdcfdf&language=ru-RU"
        AF.request(
            url,
            method: .get
        ).responseJSON { response in
            if let data = response.data {
                if let error = response.error {
                    complition(.failure(error))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Movies.self, from: data)
                    complition(.success(result))
                } catch {
                    complition(.failure(error))
                }
            }
        }
    }

    func getDetails(id: Int, complition: @escaping (Result<Details?, Error>) -> Void) {
        AF.request(
            "https://api.themoviedb.org/3/movie/\(id)?api_key=1ee34276a75d38c0cae118c698cdcfdf&language=ru-Ru",
            method: .get
        ).responseJSON { response in
            if let error = response.error {
                complition(.failure(error))
                return
            }
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Details.self, from: data)
                complition(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

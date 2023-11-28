// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol MoviesViewProtocol: AnyObject {
    func reloadData()
    func failure(error: Error)
}

protocol MoviesViewPresenterProtocol: AnyObject {
    var movies: [MoviesManagedObject]? { get set }
    func tapOnTheComment(id: Int)
}

final class MainPresenter: MoviesViewPresenterProtocol {
    let view: MoviesViewProtocol?
    var router: RouterProtocol?
    // var movies: Movies?
    var movies: [MoviesManagedObject]?
    let networkService: NetworkServiceProtocol!
    let coreDataStorage = CoreDataStorage()

    init(view: MoviesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getMovies()
    }

    func tapOnTheComment(id: Int) {
        router?.showDetail(id: id)
    }

    func getMovies() {
        networkService.getMovies { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(movie):
                    self.coreDataStorage.save(films: movie.results)
                    let object = self.coreDataStorage.getObects()
                    self.movies = object
                    self.view?.reloadData()
                case let .failure(error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

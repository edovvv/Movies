// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailViewProtocol: AnyObject {
    func reloadData()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
    var details: Details? { get set }
    var id: Int { get }
    func getDetail(id: Int)
}

final class DetailPresenter: DetailViewPresenterProtocol {
    var details: Details?

    let coreDataStorage = CoreDataStorage()
    var id: Int
    let view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var dataStorageService: DataStorageServiceProtocol?

    init(
        view: DetailViewProtocol,
        networkService: MovieAPIService,
        id: Int,
        dataStorageService: DataStorageServiceProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.dataStorageService = dataStorageService
        self.id = id
        getDetail(id: id)
    }

    func getDetail(id: Int) {
        networkService.getDetails(id: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.details = data
                    self.view?.reloadData()
                case let .failure(error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

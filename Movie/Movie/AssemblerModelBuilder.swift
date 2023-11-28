// AssemblerModelBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol AssmblerBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(id: Int, router: RouterProtocol) -> UIViewController
}

final class AssemblerModelBuilder: AssmblerBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MoviesViewController()
        let networkService = MovieAPIService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    func createDetailModule(id: Int, router _: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let dataStorageService = DataStorageService()
        let networkService = MovieAPIService()
        let presenter = DetailPresenter(
            view: view,
            networkService: networkService,
            id: id,
            dataStorageService: dataStorageService
        )
        view.presenter = presenter
        return view
    }
}

// Router.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssmblerBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(id: Int)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssmblerBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssmblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetail(id: Int) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(id: id, router: self)
            else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}

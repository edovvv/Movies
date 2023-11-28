// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// сен делегат
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblerModelBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

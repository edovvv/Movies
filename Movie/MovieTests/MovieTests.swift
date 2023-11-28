// MovieTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class MovieTests: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblerModelBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.showDetail(id: 0)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}

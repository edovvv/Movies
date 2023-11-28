// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ViewController
final class MoviesViewController: UIViewController {
    // MARK: - Private Properties

    var presenter: MoviesViewPresenterProtocol?

    private var myTableView = UITableView()
    private let identifire = "MyCell"
    private var titleLabel: String?
    private var imageString: String?
    private var overviewLabel: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Movie"
        createTableView()
    }

    // MARK: - create Private Medoth

    private func createTableView() {
        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: identifire)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(myTableView)
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        200
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let networkService = MovieAPIService()
        let dataStorageService = DataStorageService()
        let newVC = DetailViewController()
        let id = presenter?.movies?[indexPath.row].id ?? 0
        let presenterSecondVC = DetailPresenter(
            view: newVC,
            networkService: networkService,
            id: id, dataStorageService: dataStorageService
        )
        newVC.presenter = presenterSecondVC
        presenter?.tapOnTheComment(id: id)
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifire) as? MyTableViewCell
        else { return UITableViewCell() }
        guard let movie = presenter?.movies?[indexPath.row] else { return UITableViewCell() }
        cell.configur(movie: movie)
        return cell
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func reloadData() {
        myTableView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

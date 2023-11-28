// MyTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MyTableViewCell: UITableViewCell {
    // MARK: - Private Properties

    private let movieNameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let movieImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let imageService = ImageService()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAnchor()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        createMovieNameLable()
        createMovieImageLable()
        createOwerviewLable()
    }

    // MARK: - Private Medoth

    private func createMovieNameLable() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.numberOfLines = 0
        contentView.addSubview(movieNameLabel)
    }

    private func createMovieImageLable() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
    }

    private func createOwerviewLable() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 0
        contentView.addSubview(overviewLabel)
    }

    // MARK: - create Anchor

    private func cellAnchor() {
        contentView.addSubview(movieImageView)
        movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 3).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        contentView.addSubview(movieNameLabel)
        movieNameLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        contentView.addSubview(overviewLabel)
        overviewLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 10).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    // MARK: - crete Configur

    func configur(movie: MoviesManagedObject) {
        movieNameLabel.text = movie.title
        overviewLabel.text = movie.overview

        DispatchQueue.global().async {
            let posterPath = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            guard let url = URL(string: posterPath) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            self.imageService.getImage(url: url) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.movieImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}

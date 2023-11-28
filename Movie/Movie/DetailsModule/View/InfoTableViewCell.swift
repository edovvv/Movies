// InfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class InfoTableViewCell: UITableViewCell {
    // MARK: - Private Properties

    private let myImageView = UIImageView()
    private let myTitileLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageService = ImageService()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createTitleLabel()
        createImageView()
        createDescriptionLabel()
        cellAnchor()
    }

    // MARK: - Private Methods

    private func createImageView() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(myImageView)
    }

    private func createTitleLabel() {
        myTitileLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(myTitileLabel)
    }

    private func createDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
    }

    // MARK: - Anchors

    private func cellAnchor() {
        contentView.addSubview(myImageView)
        myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        myImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50).isActive = true
        myImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50).isActive = true
        myImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -400).isActive = true

        contentView.addSubview(myTitileLabel)
        myTitileLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        myTitileLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        myTitileLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 20).isActive = true
        myTitileLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

        contentView.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: myTitileLabel.bottomAnchor, constant: 20).isActive = true
    }

    // MARK: - Func configurDetails

    func configurDetails(movie2: Details) {
        myTitileLabel.text = movie2.title
        descriptionLabel.text = movie2.overview
        DispatchQueue.global().async {
            let posterPath = "https://image.tmdb.org/t/p/w500\(movie2.posterPath ?? "")"
            guard let url = URL(string: posterPath) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            // добавил
            self.imageService.getImage(url: url) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.myImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}

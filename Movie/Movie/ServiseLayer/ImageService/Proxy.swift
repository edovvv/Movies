// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol LoadImageProtocol {
    func loadImage(url: URL, complition: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

final class Proxy: LoadImageProtocol {
    private let imageAPIService: ImageAPIServiceProtocol
    private let cacheImageService: ChacheImageServiceProtocol

    init(service: ImageAPIServiceProtocol, cacheImageService: ChacheImageServiceProtocol) {
        imageAPIService = service
        self.cacheImageService = cacheImageService
    }

    func loadImage(url: URL, complition: @escaping (Result<UIImage, Error>) -> Void) {
        let image = cacheImageService.getImageFromCache(url: url.absoluteString)

        if image == nil {
            imageAPIService.grtPhoto(url: url) { result in
                switch result {
                case let .success(image):
                    self.cacheImageService.saveImageToChache(url: url.absoluteString, image: image)
                    complition(.success(image))
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } else {
            guard let image = image else { return }
            complition(.success(image))
        }
    }
}

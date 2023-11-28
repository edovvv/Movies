// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func getImage(url: URL, completion: @escaping (UIImage) -> Void)
}

final class ImageService: ImageServiceProtocol {
    func getImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let imageAPIService = ImageAPIService()
        let cacheImageService = ChacheImageService()
        let proxy = Proxy(service: imageAPIService, cacheImageService: cacheImageService)

        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

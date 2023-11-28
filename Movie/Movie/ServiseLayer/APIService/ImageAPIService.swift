// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import AlamofireImage
import Foundation
import UIKit

protocol ImageAPIServiceProtocol {
    func grtPhoto(url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

final class ImageAPIService: ImageAPIServiceProtocol {
    func grtPhoto(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.request(url).responseImage { response in
            if case let .success(image) = response.result {
                completion(.success(image))
            }
            if let error = response.error {
                completion(.failure(error))
                return
            }
        }
    }
}

//
//  HomeImageVM.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 11.5.21..
//

import UIKit

class LaunchImageVM {
    
    var imageUrlString: String
    var imagePlaceholderName: String
    var isRounded = true
    var imageTransition = Double(0.7)

    init(imageUrlString: String, imagePlaceholderName: String = "rocketImg") {
        self.imageUrlString = imageUrlString
        self.imagePlaceholderName = imagePlaceholderName
    }

    func getImage(withName imageName: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        urlSessionDataTask = launchesService.fetch(image: imageName, completion: { (result) in
            completion(result)
        })
        
    }
    
    func cancelImageDownload() {
        urlSessionDataTask?.cancel()
    }
    
    // MARK: - Properties
    private var urlSessionDataTask: URLSessionDataTask?
    private let launchesService = LaunchesService()
}

extension LaunchImageVM {
    func getCachedImage(imageName: String) -> UIImage? {
        if let image = ImageHelper.shared.imageCache.object(forKey: imageName as NSString) {
            return image
        }
        return nil
    }
    
    func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
}

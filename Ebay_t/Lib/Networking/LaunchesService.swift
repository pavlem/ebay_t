//
//  CatalogService.swift
//  Ebay_t
//
//   Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class LaunchesService: NetworkService {
    
    // MARK: - API
    func fetch(image imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {
        
        guard let url = URL(string: imageUrl) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(img))
        }
        task.resume()
        return task
    }
    
    func fetchLaunches(launchRequest: LaunchRequest, completion: @escaping (Result<LaunchResponse?, NetworkError>) -> ()) -> URLSessionDataTask? {

        return load(urlString: urlString, path: path, method: .get, params: launchRequest.body(), headers: nil) { (result: Result<LaunchResponse?, NetworkError>) in
            
            switch result {
            case .success(let catalogResponse):
                completion(.success(catalogResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    // MARK: - Properties
    private let scheme = "https://"
    private let host = "ll.thespacedevs.com/"
    private let path = "2.0.0/launch/upcoming"
    
    private var urlString: String {
        return scheme + host
    }
}

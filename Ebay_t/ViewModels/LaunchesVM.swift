//
//  LaunchesVM.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

class LaunchesVM {
    
    // MARK: - API
    var isLoadingScreenShown = true
    let launchesListTitle = "Launches List"
    let loadFailText = "Failed to load..."
    let searchPlaceholder = "Search launches..."

    let backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
    
    func cancelCatalogsFetch() {
        dataTask?.cancel()
    }
    
    func fetch(launchRequest: LaunchRequest, completion: @escaping (Result<[LaunchVM], NetworkError>) -> ()) {
        fetchData(launchRequest: launchRequest) { result in
            completion(result)
        }
    }
    
    // MARK: - Inits
    init(isLoadingScreenShown: Bool) {
        self.isLoadingScreenShown = isLoadingScreenShown
    }
    
    // MARK: - Properties

    private var dataTask: URLSessionDataTask?
    private let launchesService = LaunchesService()
    
    // MARK: - Helper
    private func fetchData(launchRequest: LaunchRequest, completion: @escaping (Result<[LaunchVM], NetworkError>) -> ()) {
        
        // In case of throtling issues from the server uncomment this part of the code so that JSON response is taken from the local file instead from the Rest API
//        fetchMOCLaunches { launcheVMs in
//            completion(.success(launcheVMs))
//        }
        
        // In case of throtling issues from the server comment this part of the code which is the real networking
        dataTask = launchesService.fetchLaunches(launchRequest: launchRequest, completion: { result in

            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let response):
                guard let launches = response?.results else { return }
                let launcheVMs = launches.map { LaunchVM(launchResponseItem: $0) }
                completion(.success(launcheVMs))
            }
        })
    }
}

// MARK: These are just helper method since there is a problem of throttling with the server where I experienced cooldown of even up to 3000 seconds. !!!!
// I tried in the postman and it's the same thing, I get
//{
//    "detail": "Request was throttled. Expected available in 2900 seconds."
//}
func fetchMOCLaunches(delay: Int = 0, completion: @escaping ([LaunchVM]) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
        let filePath = "launchesMOC"
        loadJsonDataFromFile(filePath, completion: { data in
            if let json = data {
                do {
                    let launchesResponse = try JSONDecoder().decode(LaunchResponse.self, from: json)
                    let launchesVMs = launchesResponse.results.map { LaunchVM(launchResponseItem: $0) }
                    completion(launchesVMs)
                } catch _ as NSError {
                    fatalError("Couldn't load data from \(filePath)")
                }
            }
        })
    }
}

func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
    if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            completion(data as Data)
        } catch {
            completion(nil)
        }
    }
}


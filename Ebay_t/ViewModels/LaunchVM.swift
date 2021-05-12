//
//  LaunchVM.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

struct LaunchVM {
    
    // MARK: - API
    mutating func fetchImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        dataTask = launchesService.fetch(image: imageUrl) { result in
            completion(result)
        }
    }
    
    let detailedName: String
    let windowEndDate: String
    let launchServiceProviderName: String
    let rocketConfigurationFamily: String
    let missionName: String
    let missionOrbitName: String
    let padLocationName: String
    let padLocationCountryCode: String
    let padMapImageUrl: String
    let padMapUrl: String
    let imageUrl: String?
    
    // Calculated
    var nameDescription: String {
        return missionName.uppercased()
    }
    
    var familyDescription: String {
        return "Family: " + rocketConfigurationFamily
    }
    
    var launchDescription: String {
        return "Launch: " + endDateDescription
    }
    
    var locationDescription: String {
        return "Location: " + padLocationCountryCode + " " + countryFlag(for: padLocationCountryCode)
    }
    
    var endDateDescription: String {
        return LaunchVM.getCellFormatedDate(isoDate: self.windowEndDate) ?? ""
    }
    
    // MARK: Constants
    
    let cellHeight = CGFloat(130)
    
    let nameLblFont = UIFont.boldSystemFont(ofSize: 18)
    let launchDateLblFont = UIFont.boldSystemFont(ofSize: 16)
    let familyLblFont = UIFont.systemFont(ofSize: 16)
    let locationLblFont = UIFont.systemFont(ofSize: 16)
    
    let txtColor = UIColor.lightGray
    
    let backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
    let seperatorColor = UIColor.lightGray
    
    // MARK: Properties
    private var dataTask: URLSessionDataTask?
    private let launchesService = LaunchesService()
}

extension LaunchVM {
    init(launchResponseItem: LaunchResponseItem) {
        detailedName = launchResponseItem.name
        windowEndDate = launchResponseItem.windowEnd
        launchServiceProviderName = launchResponseItem.launchServiceProvider.name
        rocketConfigurationFamily = launchResponseItem.rocket.configuration.family
        missionName = launchResponseItem.mission?.name ?? "No mission name"
        missionOrbitName = launchResponseItem.mission?.orbit?.name ?? "No mission orbit name"
        padLocationName = launchResponseItem.pad.location.name
        padLocationCountryCode = launchResponseItem.pad.location.countryCode
        padMapImageUrl = launchResponseItem.pad.mapImage
        padMapUrl = launchResponseItem.pad.mapURL
        imageUrl = launchResponseItem.image
    }
}

extension LaunchVM {
    func countryFlag(for threeLetterCountryCode: String) -> String {
        guard let twoLetterCode = CountryUtilities.getAlphaTwoCode(byAlpha3Code: threeLetterCountryCode) else { return "" }
        return CountryUtilities.getFlag(for: twoLetterCode)
    }
    
    static func getCellFormatedDate(isoDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from:isoDate) else { return nil }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .second, .timeZone], from: date)
        
        guard let finalDate = calendar.date(from:components) else { return nil }
        let dateFormatterForStringDate = DateFormatter()
        dateFormatterForStringDate.dateFormat = "yyyy-MM-dd, HH:mm"
        return dateFormatterForStringDate.string(from: finalDate)
    }
}

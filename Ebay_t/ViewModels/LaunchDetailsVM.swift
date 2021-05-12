//
//  LaunchDetailsVM.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

struct LaunchDetailsVM {
    
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
    let image: UIImage?
    
    // MARK: - Calculated
    var launchText: String {
        return "Details:\n" + detailedName + ", " + missionOrbitName + "\n\n" +
            "Company:\n" + launchServiceProviderName + ", " + rocketConfigurationFamily + "\n\n" +
            "Location:\n" +  padLocationName + ", " + padLocationCountryCode
    }
    
    // MARK: - Constants
    let textFont = UIFont.boldSystemFont(ofSize: 20)
    let textColor = UIColor.white
    let viewBackground = UIColor.black
    let viewAlpha = CGFloat(0.6)
    let isTextEditable = false
    let isMapImageRounded = false
    let mapImageTransition = 1.5
}

extension LaunchDetailsVM {
    init(launchVM: LaunchVM, image: UIImage?) {
        detailedName = launchVM.detailedName
        windowEndDate = launchVM.windowEndDate
        launchServiceProviderName = launchVM.launchServiceProviderName
        rocketConfigurationFamily = launchVM.rocketConfigurationFamily
        missionName = launchVM.missionName
        missionOrbitName = launchVM.missionOrbitName
        padLocationName = launchVM.padLocationName
        padLocationCountryCode = launchVM.padLocationCountryCode
        padMapImageUrl = launchVM.padMapImageUrl
        padMapUrl = launchVM.padMapUrl
        imageUrl = launchVM.imageUrl
        self.image = image
    }
}

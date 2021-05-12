//
//  LaunchResponse.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import Foundation

// MARK: - Welcome
struct LaunchResponse: Codable {
    let count: Int
    let next: String
    let results: [LaunchResponseItem]
}

// MARK: - Result
struct LaunchResponseItem: Codable {
    let id: String
    let url: String
    let launchLibraryID: Int?
    let slug, name: String
    let net, windowEnd, windowStart: String
    let inhold, tbdtime, tbddate: Bool
    let probability: Int?
    let holdreason, failreason: String?
    let launchServiceProvider: LaunchServiceProvider
    let rocket: Rocket
    let mission: Mission?
    let pad: Pad
    let webcastLive: Bool
    let image: String?
    let infographic: String?
    let program: [Program]

    enum CodingKeys: String, CodingKey {
        case id, url
        case launchLibraryID = "launch_library_id"
        case slug, name, net
        case windowEnd = "window_end"
        case windowStart = "window_start"
        case inhold, tbdtime, tbddate, probability, holdreason, failreason
        case launchServiceProvider = "launch_service_provider"
        case rocket, mission, pad
        case webcastLive = "webcast_live"
        case image, infographic, program
    }
}

// MARK: - LaunchServiceProvider
struct LaunchServiceProvider: Codable {
    let id: Int
    let url: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case commercial = "Commercial"
    case government = "Government"
}

// MARK: - Mission
struct Mission: Codable {
    let id: Int
    let launchLibraryID: Int?
    let name, missionDescription: String
    let type: String
    let orbit: Orbit?

    enum CodingKeys: String, CodingKey {
        case id
        case launchLibraryID = "launch_library_id"
        case name
        case missionDescription = "description"
        case type, orbit
    }
}

// MARK: - Orbit
struct Orbit: Codable {
    let id: Int
    let name, abbrev: String
}

// MARK: - Pad
struct Pad: Codable {
    let id: Int
    let url: String
    let agencyID: Int?
    let name: String
    let wikiURL: String
    let mapURL: String
    let latitude, longitude: String
    let location: Location
    let mapImage: String
    let totalLaunchCount: Int

    enum CodingKeys: String, CodingKey {
        case id, url
        case agencyID = "agency_id"
        case name
        case wikiURL = "wiki_url"
        case mapURL = "map_url"
        case latitude, longitude, location
        case mapImage = "map_image"
        case totalLaunchCount = "total_launch_count"
    }
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let url: String
    let name, countryCode: String
    let mapImage: String
    let totalLaunchCount, totalLandingCount: Int

    enum CodingKeys: String, CodingKey {
        case id, url, name
        case countryCode = "country_code"
        case mapImage = "map_image"
        case totalLaunchCount = "total_launch_count"
        case totalLandingCount = "total_landing_count"
    }
}

// MARK: - Program
struct Program: Codable {
    let id: Int
    let url: String
    let name, programDescription: String
    let agencies: [LaunchServiceProvider]
    let imageURL: String
    let wikiURL: String

    enum CodingKeys: String, CodingKey {
        case id, url, name
        case programDescription = "description"
        case agencies
        case imageURL = "image_url"
        case wikiURL = "wiki_url"
    }
}

// MARK: - Rocket
struct Rocket: Codable {
    let id: Int
    let configuration: Configuration
}

// MARK: - Configuration
struct Configuration: Codable {
    let id, launchLibraryID: Int
    let url: String
    let name, family, fullName, variant: String

    enum CodingKeys: String, CodingKey {
        case id
        case launchLibraryID = "launch_library_id"
        case url, name, family
        case fullName = "full_name"
        case variant
    }
}

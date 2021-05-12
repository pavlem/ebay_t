//
//  Ebay_tTests.swift
//  Ebay_tTests
//
//  Created by Pavle Mijatovic on 12.5.21..
//

import XCTest
@testable import Ebay_t

class Ebay_tTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // CountdownLabelVM
    func testCountdownLabelVMGetDiff() {
        
        let date1 = Date(timeIntervalSinceReferenceDate: 642622469.008368)
        let diff1 = CountdownLabelVM(date: "2021-05-15T12:05:00Z").getDiff(startTime: date1, endTimeString: "2021-05-15T12:05:00Z")
        XCTAssert(diff1 == "T-: 1 d 17 h 50 m 30 s")
        
        let date2 = Date(timeIntervalSinceReferenceDate: 642622502.833744)
        let diff2 = CountdownLabelVM(date: "").getDiff(startTime: date2, endTimeString: "2021-05-31T00:00:00Z")
        XCTAssert(diff2 == "T-: 17 d 5 h 44 m 57 s")
    }
    
    // LaunchDetailsVM
    func testLaunchDetailsVMInitWithLaunchVM() {
        let asyncExpectation = expectation(description: "Async block executed")

        Ebay_tTests.fetchMOCLaunches { (launches) in
            let launchVM1 = launches.first!
            let launchVM2 = launches[1]
            
            let vmD1 = LaunchDetailsVM(launchVM: launchVM1, image: nil)
            let vmD2 = LaunchDetailsVM(launchVM: launchVM2, image: nil)

            XCTAssert(vmD1.detailedName == launchVM1.detailedName)
            XCTAssert(vmD1.windowEndDate == launchVM1.windowEndDate)
            XCTAssert(vmD1.launchServiceProviderName == launchVM1.launchServiceProviderName)
            XCTAssert(vmD1.rocketConfigurationFamily == launchVM1.rocketConfigurationFamily)
            XCTAssert(vmD1.missionName == launchVM1.missionName)
            XCTAssert(vmD1.missionOrbitName == launchVM1.missionOrbitName)
            XCTAssert(vmD1.padLocationName == launchVM1.padLocationName)
            XCTAssert(vmD1.padLocationCountryCode == launchVM1.padLocationCountryCode)
            XCTAssert(vmD1.padMapImageUrl == launchVM1.padMapImageUrl)
            XCTAssert(vmD1.padMapUrl == launchVM1.padMapUrl)
            XCTAssert(vmD1.imageUrl == launchVM1.imageUrl)
            XCTAssert(vmD1.launchText ==
                        """
                Details:
                Electron | Running Out Of Toes, Low Earth Orbit

                Company:
                Rocket Lab Ltd, Electron

                Location:
                Onenui Station, Mahia Peninsula, New Zealand, NZL
                """
            )
            
            XCTAssert(vmD2.detailedName == launchVM2.detailedName)
            XCTAssert(vmD2.windowEndDate == launchVM2.windowEndDate)
            XCTAssert(vmD2.launchServiceProviderName == launchVM2.launchServiceProviderName)
            XCTAssert(vmD2.rocketConfigurationFamily == launchVM2.rocketConfigurationFamily)
            XCTAssert(vmD2.missionName == launchVM2.missionName)
            XCTAssert(vmD2.missionOrbitName == launchVM2.missionOrbitName)
            XCTAssert(vmD2.padLocationName == launchVM2.padLocationName)
            XCTAssert(vmD2.padLocationCountryCode == launchVM2.padLocationCountryCode)
            XCTAssert(vmD2.padMapImageUrl == launchVM2.padMapImageUrl)
            XCTAssert(vmD2.padMapUrl == launchVM2.padMapUrl)
            XCTAssert(vmD2.imageUrl == launchVM2.imageUrl)
            XCTAssert(vmD2.launchText ==
                        """
                Details:
                Falcon 9 Block 5 | Starlink 26, Low Earth Orbit

                Company:
                SpaceX, Falcon

                Location:
                Kennedy Space Center, FL, USA, USA
                """
            )

            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // LaunchVM
    func testLaunchVMInitWithLaunchResponseItem() {
        
        let asyncExpectation = expectation(description: "Async block executed")

        Ebay_tTests.fetchMOCLaunchesResponse { (launches) in
           
            let resp1 = launches.first!
            let vm1 = LaunchVM(launchResponseItem: resp1)

            XCTAssert(vm1.detailedName == "Electron | Running Out Of Toes")
            XCTAssert(vm1.windowEndDate == "2021-05-15T12:05:00Z")
            XCTAssert(vm1.launchServiceProviderName == "Rocket Lab Ltd")
            XCTAssert(vm1.rocketConfigurationFamily == "Electron")
            XCTAssert(vm1.missionName == "Running Out of Toes")
            XCTAssert(vm1.missionOrbitName == "Low Earth Orbit")
            XCTAssert(vm1.padLocationName == "Onenui Station, Mahia Peninsula, New Zealand")
            XCTAssert(vm1.padLocationCountryCode == "NZL")

            XCTAssert(vm1.nameDescription == "RUNNING OUT OF TOES")
            XCTAssert(vm1.familyDescription == "Family: Electron")
            XCTAssert(vm1.launchDescription == "Launch: 2021-05-15, 14:00")
            XCTAssert(vm1.locationDescription == "Location: NZL 🇳🇿")
            XCTAssert(vm1.endDateDescription == "2021-05-15, 14:00")
            
            let resp2 = launches[1]
            let vm2 = LaunchVM(launchResponseItem: resp2)
            
            XCTAssert(vm2.detailedName == "Falcon 9 Block 5 | Starlink 26")
            XCTAssert(vm2.windowEndDate == "2021-05-15T22:58:00Z")
            XCTAssert(vm2.launchServiceProviderName == "SpaceX")
            XCTAssert(vm2.rocketConfigurationFamily == "Falcon")
            XCTAssert(vm2.missionName == "Starlink 26")
            XCTAssert(vm2.missionOrbitName == "Low Earth Orbit")
            XCTAssert(vm2.padLocationName == "Kennedy Space Center, FL, USA")
            XCTAssert(vm2.padLocationCountryCode == "USA")

            XCTAssert(vm2.nameDescription == "STARLINK 26")
            XCTAssert(vm2.familyDescription == "Family: Falcon")
            XCTAssert(vm2.launchDescription == "Launch: 2021-05-16, 00:00")
            XCTAssert(vm2.locationDescription == "Location: USA 🇺🇸")
            XCTAssert(vm2.endDateDescription == "2021-05-16, 00:00")
            
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchHomesVMFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")

        Ebay_tTests.fetchMOCLaunches { (launches) in
            XCTAssert(launches.count == 10)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Helper
    
    static func fetchMOCLaunchesResponse(delay: Int = 0, completion: @escaping ([LaunchResponseItem]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "launchesMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let launchesResponse = try JSONDecoder().decode(LaunchResponse.self, from: json)
                        completion(launchesResponse.results)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
        
    }
    
    static func fetchMOCLaunches(delay: Int = 0, completion: @escaping ([LaunchVM]) -> Void) {
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

    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch {
                completion(nil)
            }
        }
    }
}

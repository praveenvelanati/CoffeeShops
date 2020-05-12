//
//  CoffeeViewModelTests.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import XCTest
@testable import CoffeeShops
import CoreLocation

class CoffeeViewModelTests: XCTestCase {

    func testFirstRequestBeingMade() {
        let location = CLLocation(latitude: 33.786991, longitude: -84.383324)
        let service = MockFSService(result: .failure(FourSquareError.BadRequest))
        let sut = CoffeeMapViewModel(service: service)
        sut.getCoffeeShops(location: location)
        XCTAssertTrue(service.requestMade)
    }
    
    func testRequestBeingMadeOnLocationChange() {
        let service = MockFSService(result: .failure(FourSquareError.BadRequest))
        let locationManager = MockLocationManager()
        let locationService = LocationService(locationManager: locationManager)
        let sut = CoffeeMapViewModel(service: service, locationService: locationService)
        sut.locationService.locationManager(locationManager, didUpdateLocations: [CLLocation(latitude: 33.786991, longitude: -84.383324)])
        XCTAssertTrue(service.requestMade)
    }
    
    func testAnnotationCount() {
        let location = CLLocation(latitude: 33.786991, longitude: -84.383324)
        guard let searchResponse = getSuccesfulResponse(fileName: "Mockdata") else {
            XCTFail()
            return
        }
        let service = MockFSService(result: .success(searchResponse))
        let locationService = LocationService(locationManager: MockLocationManager())
        let sut = CoffeeMapViewModel(service: service, locationService: locationService)
        sut.currentLocation = location
        sut.getCoffeeShops(location: location)
        XCTAssertEqual(sut.annotations.count, 2)
    }
    
    func testErrorResponse() {
        let location = CLLocation(latitude: 33.786991, longitude: -84.383324)
        guard let searchResponse = getSuccesfulResponse(fileName: "ErrorResponse") else {
            XCTFail()
            return
        }
        let service = MockFSService(result: .success(searchResponse))
        let locationService = LocationService(locationManager: MockLocationManager())
        let sut = CoffeeMapViewModel(service: service, locationService: locationService)
        sut.getCoffeeShops(location: location)
        XCTAssertNotNil(sut.errorAlert)
        XCTAssertEqual(sut.errorAlert?.title, "invalid_auth")
    }
    
    
    func getSuccesfulResponse(fileName: String) -> SearchResponse? {
        guard let file = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: file, options: .alwaysMapped) else {
            return nil
        }
        do {
          return try JSONDecoder().decode(SearchResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

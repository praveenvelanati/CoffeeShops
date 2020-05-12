//
// LocationServiceTests.swift
// CoffeeShopsTests

// Created by praveen velanati on 5/10/20.
// Copyright © 2020 praveen velanati. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoffeeShops

class LocationServiceTests: XCTestCase {

    private func makeRandomLocation() -> CLLocation {
        let latitude = CLLocationDegrees.random(in: -179..<179)
        let longitude = CLLocationDegrees.random(in: -179..<179)
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    
    func testUserPermission() {
        let locationManager = MockLocationManager()
        MockLocationManager.globalAuthStatus = .denied
        let sut = LocationService(locationManager: locationManager)
        XCTAssertEqual(sut.userPermission, .denied)
        
        MockLocationManager.globalAuthStatus = .notDetermined
        XCTAssertEqual(sut.userPermission, .unknown)
        
        MockLocationManager.globalAuthStatus = .authorizedWhenInUse
        XCTAssertEqual(sut.userPermission, .granted)
        
    }
    
    func testRequestedWhenInAuthUse() {
        let locationManager = MockLocationManager()
        MockLocationManager.globalAuthStatus = .notDetermined
        let sut = LocationService(locationManager: locationManager)
        sut.request()
        XCTAssertTrue(locationManager.didRequestAuthWhenInUse)
    }
    
    func testRequestedLocationWhenPermissionGranted() {
        let locationManager = MockLocationManager()
        MockLocationManager.globalAuthStatus = .authorizedWhenInUse
        let sut = LocationService(locationManager: locationManager)
        sut.request()
        XCTAssertTrue(locationManager.didRequestLocation)
    }
    
    func testUpdatedLocationWhenPermissionGranted() {
        let locationManager = MockLocationManager()
        let randomLocation = makeRandomLocation()
        locationManager.requestedLocations = [randomLocation]
        MockLocationManager.globalAuthStatus = .authorizedWhenInUse
        let sut = LocationService(locationManager: locationManager)
        sut.request()
        XCTAssertEqual(sut.currentLocation?.coordinate.latitude, randomLocation.coordinate.latitude)
        XCTAssertEqual(sut.currentLocation?.coordinate.longitude, randomLocation.coordinate.longitude)
    }

}

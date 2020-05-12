//
//  MockLocationManager.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import CoreLocation

final class MockLocationManager: CLLocationManager {
    
    
    static var globalAuthStatus: CLAuthorizationStatus = .denied
    var requestedLocations: [CLLocation] = []
    var requestedAuthorizationStatus: CLAuthorizationStatus = .denied
    private(set) var didRequestLocation: Bool = false
    private(set) var didRequestAuthWhenInUse = false
    
    override class func authorizationStatus() -> CLAuthorizationStatus {
         return globalAuthStatus
    }
    
    
    override func requestLocation() {
        didRequestLocation = true
        delegate?.locationManager?(self, didUpdateLocations: requestedLocations)
    }
    
    override func requestWhenInUseAuthorization() {
        didRequestAuthWhenInUse = true
        delegate?.locationManager?(self, didChangeAuthorization: requestedAuthorizationStatus)
    }
    
    
}

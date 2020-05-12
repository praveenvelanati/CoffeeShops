//
//  LocationService.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import CoreLocation


protocol LocationServiceProtocol: class {
    func locationService(didChangeAuthorization status: CLAuthorizationStatus)
    
    func locationService(didUpdateLocations location: CLLocation)
    
    func locationService(didFailWithError error: UserLocationRequestError)
}

class LocationService: NSObject, CLLocationManagerDelegate {
   
    
    private let locationManager: CLLocationManager
    private(set) var currentLocation: CLLocation?
    weak var delegate: LocationServiceProtocol?
    
    var userPermission: UserLocationPermissionStatus {
        switch type(of: locationManager).authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return .granted
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .unknown
        @unknown default:
            return .unknown
        }
    }
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func request() {
        guard CLLocationManager.locationServicesEnabled() else {
            delegate?.locationService(didFailWithError: .disabled)
            return
        }
        let currentAuthorizationStatus = type(of: locationManager).authorizationStatus()
        if currentAuthorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else if currentAuthorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if currentAuthorizationStatus == .denied {
            delegate?.locationService(didFailWithError: .denied)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse:
            delegate?.locationService(didChangeAuthorization: status)
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
           delegate?.locationService(didFailWithError: UserLocationRequestError.denied)
        default:
            print("Not required")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.currentLocation = location
        delegate?.locationService(didUpdateLocations: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationService(didFailWithError: UserLocationRequestError.requestFailed)
    }
    
}




enum UserLocationPermissionStatus {
    case granted
    case denied
    case unknown
}

enum UserLocationRequestError {
    case requestFailed
    case denied
    case disabled
}

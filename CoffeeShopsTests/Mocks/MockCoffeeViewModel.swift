//
//  MockCoffeeViewModel.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/11/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
@testable import CoffeeShops
import CoreLocation

class MockCoffeeViewModel: CoffeeMapViewModelType {
    var annotations: [FSAnnotation] = []
    
    var errorAlert: ErrorAlert?
    
    
    var service: FourSquareServiceType?
    var locationService: LocationService
    var delegate: CoffeeMapResultsProtocol?
    
    required init(service: FourSquareServiceType, locationService: LocationService) {
        self.service = service
        self.locationService = locationService
    }
    
    var currentLocation: CLLocation?
 
 
    func getCoffeeShops(location: CLLocation) {
       let annotations = [FSAnnotation(venue: Venue(id: "", name: "", location: nil, categories: nil))]
        delegate?.updateMapWith(annotations, location: CLLocation(latitude: 10.0, longitude: 10.0))
    }
    
    
}

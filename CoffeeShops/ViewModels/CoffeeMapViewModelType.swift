//
//  CoffeeMapViewModelType.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/11/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import CoreLocation

protocol CoffeeMapViewModelType {
    func getCoffeeShops(location: CLLocation)
    var delegate: CoffeeMapResultsProtocol? { get set }
    init(service: FourSquareServiceType, locationService: LocationService)
    var service: FourSquareServiceType? { get }
    var locationService: LocationService { get }
    var annotations: [FSAnnotation] { get }
    var errorAlert: ErrorAlert? { get }
}

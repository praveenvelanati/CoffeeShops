//
//  CoffeeMapViewModel.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import CoreLocation

protocol CoffeeMapResultsProtocol: class {
    func updateMapWith(_ annotations: [FSAnnotation], location: CLLocation)
    func alertUserWith(_ title: String, message: String)
}

struct ErrorAlert {
    var title: String
    var message: String
}


class CoffeeMapViewModel: CoffeeMapViewModelType {
   
    var errorAlert: ErrorAlert?
    var annotations: [FSAnnotation] = []
    var service: FourSquareServiceType?
    weak var delegate: CoffeeMapResultsProtocol?
    var locationService: LocationService
    var currentLocation: CLLocation?
    
    required init(service: FourSquareServiceType = FourSquareService(), locationService: LocationService = LocationService()) {
        self.service = service
        self.locationService = locationService
        self.locationService.delegate = self
        self.locationService.request()
    }
    
    func getCoffeeShops(location: CLLocation) {
        service?.getCofeeShops(fsRequest: buildRequest(lat: location.coordinate.latitude, long: location.coordinate.longitude), completion: { [unowned self](result) in
            switch result {
            case .success(let searchResults):
                self.convertLocationsToAnnotations(response: searchResults)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        })
    }
    
    func buildRequest(lat: Double, long: Double) -> FourSquareRequest {
        var queryParams = [String: String]()
        queryParams[QueryKeys.ll.rawValue] = "\(lat),\(long)"
        queryParams[QueryKeys.client_id.rawValue] = FourSquareRequest.clientId
        queryParams[QueryKeys.client_secret.rawValue] = FourSquareRequest.clientSecret
        queryParams[QueryKeys.v.rawValue] = FourSquareRequest.version
        queryParams[QueryKeys.limit.rawValue] = "50"
        queryParams[QueryKeys.categoryId.rawValue] = FourSquareRequest.coffeeCategoryId
        return FourSquareRequest(dict: queryParams)
    }
    
    func convertLocationsToAnnotations(response: SearchResponse) {
        let metadata = response.meta
        if let errorTitle = metadata?.errorType, let errorMsg = metadata?.errorDetail {
            self.errorAlert = ErrorAlert(title: errorTitle, message: errorMsg)
            delegate?.alertUserWith(errorTitle, message: errorMsg)
        } else {
            if let location = currentLocation, let venues = response.response?.venues {
                self.annotations = venues.map({ FSAnnotation(venue: $0) })
                delegate?.updateMapWith(self.annotations, location: location)
            }
        }
    }
}

extension CoffeeMapViewModel: LocationServiceProtocol {
  
    func locationService(didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
   
    func locationService(didFailWithError error: UserLocationRequestError) {
        
        switch error {
        case .denied:
            delegate?.alertUserWith("Permission Denied", message: "Permission to acess location has been diabled.")
        case .disabled:
            delegate?.alertUserWith("Location Services disabled", message: "Access to Location services has been disabled")
        default:
            print("Request failed for unknown reason")
        }
    }
    
    func locationService(didUpdateLocations location: CLLocation) {
        self.currentLocation = location
        self.getCoffeeShops(location: location)
    }
    
}

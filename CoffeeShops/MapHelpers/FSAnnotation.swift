//
//  FSAnnotation.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import MapKit

class FSAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let address: String?
    let coordinate: CLLocationCoordinate2D
    
    
    init(venue: Venue) {
        self.title = venue.name
        if let formattedAddress = venue.location?.formattedAddress {
            self.address = formattedAddress.joined(separator: ", ")
        } else {
            self.address = venue.location?.address ?? ""
        }
        self.coordinate = CLLocationCoordinate2D(latitude: venue.location?.lat ?? 0.0, longitude: venue.location?.lng ?? 0.0)
    }
    
    
}

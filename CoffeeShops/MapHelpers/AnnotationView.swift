//
//  AnnotationView.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
import MapKit

class AnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        
        willSet {
            
            guard let fsAnnotation = newValue as? FSAnnotation else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -7, y: 7)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = fsAnnotation.address
            detailCalloutAccessoryView = detailLabel
            glyphImage = UIImage(imageLiteralResourceName: "coffee")
        }
        
        
    }
    
}

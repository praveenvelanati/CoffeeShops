//
//  ViewController.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = LocationService()
    var coffeeViewModel: CoffeeMapViewModelType?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        coffeeViewModel = CoffeeMapViewModel()
        coffeeViewModel?.delegate = self
    }
    
    func configureMapView() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}

extension ViewController: CoffeeMapResultsProtocol {
    
    func updateMapWith(_ annotations: [FSAnnotation], location: CLLocation) {
        DispatchQueue.main.async {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotations(annotations)
        }
    }
    
    func alertUserWith(_ title: String, message: String) {
        DispatchQueue.main.async {
            self.presentAlert(title: title, message: message)
        }
    }
    
}

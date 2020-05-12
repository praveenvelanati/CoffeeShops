//
//  UIVIewControllerExtesnions.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/11/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }
}

//
//  URLExtensions.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/11/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation


extension URL {
    
    func getQueryItemValueForKey(_ key: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        guard let queryItems = components.queryItems else { return nil }
        return queryItems.filter {
            $0.name == key
            }.first?.value
    }
}

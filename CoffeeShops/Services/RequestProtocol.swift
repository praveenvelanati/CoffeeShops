//
//  RequestProtocol.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

 protocol FourSquareRequestType {
    var domain: String { get }
    var path : String { get }
    var queryParameters: [String: String] { get }
}


extension FourSquareRequestType {
    
    func buildUrl() -> URL? {
        let baseURL = URL(string: domain)
        var queryItems = [URLQueryItem]()
        for(key, value) in queryParameters {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        guard let url = baseURL?.appendingPathComponent(self.path) else {
            return nil
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else  {
            return nil
        }
        urlComponents.queryItems = queryItems
        return  urlComponents.url
    }
}


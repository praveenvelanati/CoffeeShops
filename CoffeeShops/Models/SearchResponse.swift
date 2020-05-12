//
//  SearchResponse.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/8/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let errorType: String?
    let errorDetail: String?
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
}

struct Category: Codable {
    let id, name, pluralName, shortName: String?
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let distance: Int?
    let postalCode, cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}

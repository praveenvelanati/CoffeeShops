//
//  MockRequest.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
@testable import CoffeeShops

struct MockRequest: FourSquareRequestType {
    var domain: String
    var path: String
    var queryParameters: [String : String]
}


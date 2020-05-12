//
//  FourSuareRequestTests.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import XCTest
@testable import CoffeeShops

class FourSuareRequestTests: XCTestCase {

    func testValidUrlWithQueryItems() {
        let request = FourSquareRequest(dict: ["key1": "one", "key2": "two"])
        let url = request.buildUrl()
        let key1 = url?.getQueryItemValueForKey("key1")
        let key2 = url?.getQueryItemValueForKey("key2")
        XCTAssertEqual(key1, "one")
        XCTAssertEqual(key2, "two")
    }
}

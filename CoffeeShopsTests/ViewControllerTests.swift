//
//  ViewControllerTests.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/11/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import XCTest
@testable import CoffeeShops
import CoreLocation

class ViewControllerTests: XCTestCase {

    var sut: ViewController!
    
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
        sut = storyBoard.instantiateViewController(identifier: "ViewController")
        sut.loadView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadedWithMap() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testAnnotationsCount() {
        XCTAssertEqual(sut.mapView.annotations.count, 0)
    }
    
    
    

}

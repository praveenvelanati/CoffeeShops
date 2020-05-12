//
//  MockFourSquareService.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
@testable import CoffeeShops

class MockFSService: FourSquareServiceType {
    
    var result: Result<SearchResponse, Error>
    var requestMade = false
    
    
    init(result: Result<SearchResponse, Error> ) {
        self.result = result
    }
    
    func getCofeeShops(fsRequest: FourSquareRequestType, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        requestMade = true
        completion(result)
    }
    
}

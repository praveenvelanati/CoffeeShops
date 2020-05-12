//
//  FourSquareServiceTests.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import Foundation
@testable import CoffeeShops

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    var response: URLResponse?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}

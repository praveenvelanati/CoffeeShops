//
//  FourSquareServiceTests.swift
//  CoffeeShopsTests
//
//  Created by praveen velanati on 5/10/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import XCTest
@testable import CoffeeShops

class FourSquareServiceTests: XCTestCase {

    
    func testBadRequest() {
        let networkSession = NetworkSessionMock()
        networkSession.error = FourSquareError.BadRequest
        let sut = FourSquareService(session: networkSession)
        let fsRequest = MockRequest(domain: "", path: "", queryParameters: ["":""])
        sut.getCofeeShops(fsRequest: fsRequest) { (result) in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error as FourSquareError):
                XCTAssertEqual(error, FourSquareError.BadRequest)
            default:
                XCTFail()
            }
        }
    }
    
    func testBadResponse() {
        let networkSession = NetworkSessionMock()
        networkSession.error = FourSquareError.Unknown
        let sut = FourSquareService(session: networkSession)
        let fsRequest = FourSquareRequest(dict: ["":""])
        sut.getCofeeShops(fsRequest: fsRequest) { (result) in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error as FourSquareError):
                XCTAssertEqual(error, FourSquareError.Unknown)
            default:
                XCTFail()
            }
        }
    }
    
    func testSuccessfulRequest() {
        let networkSession = NetworkSessionMock()
        guard let file = Bundle(for: type(of: self)).url(forResource: "Mockdata", withExtension: "json") else {
            XCTFail()
            return
        }
        do {
            let data = try Data(contentsOf: file, options: .alwaysMapped)
            networkSession.data = data
            networkSession.response = HTTPURLResponse()
            let sut = FourSquareService(session: networkSession)
            let fsRequest = FourSquareRequest(dict: ["":""])
            sut.getCofeeShops(fsRequest: fsRequest) { (result) in
                switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                default:
                    XCTFail()
                }
            }
        } catch {
            
        }
    }

}

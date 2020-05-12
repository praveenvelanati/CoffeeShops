//
//  FourSquareRequest.swift
//  CoffeeShops
//
//  Created by praveen velanati on 5/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//


import Foundation

enum QueryKeys: String {
    case client_id, client_secret, v, categoryId, ll, limit
}

struct FourSquareRequest: FourSquareRequestType {
    
    static var clientId = "WQYKKM1H5GIJB3FROHNVAB24NB10II5UPTKBQ1EOUV0THSSL"
    static var clientSecret = "FZFIQFXZ4HETXOLBXEJIUDEA0AO2THTEUSHB13PIIMJK3QBR"
    static var coffeeCategoryId = "4bf58dd8d48988d1e0931735"
    static var version = "20180901"
    
    var domain: String = "https://api.foursquare.com"
    var queryParameters: [String : String]
    var path = "/v2/venues/search"
    
    init(dict: [String: String]) {
        self.queryParameters = dict
    }
}

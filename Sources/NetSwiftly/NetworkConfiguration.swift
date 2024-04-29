//
//  NetworkConfiguration.swift
//  
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

struct NetworkConfiguration {
    var host: String
    var scheme: String
    var apiBaseRoute: String?
    var headers: [String: String]
    var queryParameters: [String: String]
    
    init(host: String, 
         scheme: String,
         apiBaseRoute: String? = nil,
         headers: [String : String] = [:],
         queryParameters: [String : String] = [:]) {
        self.host = host
        self.scheme = scheme
        self.apiBaseRoute = apiBaseRoute
        self.headers = headers
        self.queryParameters = queryParameters
    }
}


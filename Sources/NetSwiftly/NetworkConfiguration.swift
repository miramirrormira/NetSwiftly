//
//  NetworkConfiguration.swift
//  
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public struct NetworkConfiguration {
    public var host: String
    public var scheme: String
    public var apiBaseRoute: String?
    public var headers: [String: String]
    public var queryParameters: [String: String]
    
    public init(host: String, 
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


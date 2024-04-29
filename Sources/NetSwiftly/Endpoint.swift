//
//  Endpoint.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

struct Endpoint {
    var path: String
    var method: HTTPMethod
    var headerParameters: [String: String]
    var queryParameters: [String: Any]
    var bodyParameters: [String: Any]
    var bodyEncoder: BodyEncoder
    
    init(path: String, 
         method: HTTPMethod,
         headerParameters: [String : String] = [:],
         queryParameters: [String : Any] = [:],
         bodyParameters: [String : Any] = [:],
         bodyEncoder: BodyEncoder = JSONBodyEncoder()) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.bodyEncoder = bodyEncoder
    }
}

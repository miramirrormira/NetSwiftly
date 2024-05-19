//
//  Endpoint.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public class Endpoint {
    public var path: String
    public var method: HTTPMethod
    public var headerParameters: [String: String]
    public var queryParameters: [String: Any]
    public var bodyParameters: [String: Any]
    public var bodyEncoder: BodyEncoder
    
    public init(path: String, 
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

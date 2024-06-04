//
//  URLRequestDirectorDummy.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public struct EndpointURLRequestableFake: URLRequestDirectable {
    
    public var endpoint: Endpoint
    public var networkConfiguration: NetworkConfiguration
    
    public init() {
        self.endpoint = Endpoint.fixture()
        self.networkConfiguration = NetworkConfiguration.fixture()
    }
    
    func getURL() throws -> URL {
        URL(string: "www.example.com")!
    }
    
    public func getURLRequest() throws -> URLRequest {
        URLRequest(url: try getURL())
    }
}

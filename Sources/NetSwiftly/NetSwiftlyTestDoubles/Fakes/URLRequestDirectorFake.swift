//
//  URLRequestDirectorDummy.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public struct URLRequestDirectorFake: URLRequestDirectable {
    
    public var endpoint: Endpoint
    public var networkConfiguration: NetworkConfiguration
    public let urlString: String
    
    public init(urlString: String = "www.example.com") {
        self.endpoint = Endpoint.fixture()
        self.networkConfiguration = NetworkConfiguration.fixture()
        self.urlString = urlString
    }
    
    func getURL() throws -> URL {
        URL(string: urlString)!
    }
    
    public func getURLRequest() throws -> URLRequest {
        URLRequest(url: try getURL())
    }
    
}

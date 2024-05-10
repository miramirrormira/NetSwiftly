//
//  URLRequestDirectableDecorator.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public class URLRequestDirectableDecorator: URLRequestDirectable {
    
    public var endpoint: Endpoint
    public var networkConfiguration: NetworkConfiguration
    public var urlRequestDirector: URLRequestDirectable
    
    public init(urlRequestDirector: URLRequestDirectable) {
        self.urlRequestDirector = urlRequestDirector
        self.endpoint = urlRequestDirector.endpoint
        self.networkConfiguration = urlRequestDirector.networkConfiguration
    }
    
    public func getURLRequest() async throws -> URLRequest {
        return try await urlRequestDirector.getURLRequest()
    }
}

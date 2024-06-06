//
//  URLRequestDirectableDecorator.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public class URLRequestDirectableDecorator: URLRequestDirectable {
    
    public var urlRequestDirectable: URLRequestDirectable
    
    public init(urlRequestDirectable: URLRequestDirectable) {
        self.urlRequestDirectable = urlRequestDirectable
    }
    
    public func getURLRequest() async throws -> URLRequest {
        return try await urlRequestDirectable.getURLRequest()
    }
}

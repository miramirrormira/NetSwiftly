//
//  URLRequestBuilder.swift
//  
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public class URLRequestBuilder {
    public var urlRequest: URLRequest
    
    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    @discardableResult
    public func updateHeaderFields(_ headers: [String: String]) -> URLRequestBuilder {
        if headers.isEmpty {
            return self
        }
        if urlRequest.allHTTPHeaderFields == nil {
            urlRequest.allHTTPHeaderFields = [:]
        }
        for (key, value) in headers {
            urlRequest.allHTTPHeaderFields![key] = value
        }
        return self
    }
    
    @discardableResult
    public func updateHTTPMethod(_ method: HTTPMethod) -> URLRequestBuilder {
        urlRequest.httpMethod = method.rawValue
        return self
    }
    
    @discardableResult
    public func updateHTTPBody(_ bodyParameters: [String: Any], encoder: BodyEncoder) throws -> URLRequestBuilder {
        if bodyParameters.isEmpty {
            return self
        }
        urlRequest.httpBody = try encoder.encode(bodyParameters)
        return self
    }
    
    public func exportURLRequest() -> URLRequest {
        return urlRequest
    }
}

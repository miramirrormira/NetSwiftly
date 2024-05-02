//
//  URLRequestBuilder.swift
//  
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

class URLRequestBuilder {
    var urlRequest: URLRequest
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    @discardableResult
    func updateHeaderFields(_ headers: [String: String]) -> URLRequestBuilder {
        
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
    func updateHTTPMethod(_ method: HTTPMethod) -> URLRequestBuilder {
        urlRequest.httpMethod = method.rawValue
        return self
    }
    
    @discardableResult
    func updateHTTPBody(_ bodyParameters: [String: Any], encoder: BodyEncoder) throws -> URLRequestBuilder {
        urlRequest.httpBody = try encoder.encode(bodyParameters)
        return self
    }
    
    func exportURLRequest() -> URLRequest {
        return urlRequest
    }
}

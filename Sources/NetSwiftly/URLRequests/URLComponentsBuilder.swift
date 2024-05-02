//
//  URLComponentsBuilder.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public class URLComponentsBuilder {
    public var urlComponents = URLComponents()
    
    @discardableResult
    public func addHost(_ host: String) -> URLComponentsBuilder {
        urlComponents.host = host
        return self
    }
    
    @discardableResult
    public func addScheme(_ scheme: String) -> URLComponentsBuilder {
        urlComponents.scheme = scheme
        return self
    }
    
    @discardableResult
    public func updateQueryItems(_ queryParameters: [String: Any]) -> URLComponentsBuilder {
        guard queryParameters.isEmpty == false else {
            return self
        }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = []
        }
        for (key, value) in queryParameters {
            if let index = urlComponents.queryItems?.firstIndex(where: { item in
                item.name == key
            }) {
                urlComponents.queryItems?[index].value = "\(value)"
            } else {
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        return self
    }
    
    @discardableResult
    public func appendPath(_ path: String?) -> URLComponentsBuilder {
        guard let path = path else { return self }
        let formattedPath = formatPath(path)
        urlComponents.path += formattedPath
        return self
    }
    
    private func formatPath(_ path: String) -> String {
        var pathCopy = path
        if let last = pathCopy.last, last == "/" {
            pathCopy.removeLast()
        }
        
        if let first = pathCopy.first, first != "/" {
            pathCopy = "/" + pathCopy
        }
        
        return pathCopy
    }
    
    public func exportURL() -> URL? {
        return urlComponents.url
    }
}

//
//  URLRequestDirector.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation
class URLRequestDirector: URLRequestDirectable {
    var networkConfiguration: NetworkConfiguration
    var endpoint: Endpoint
    
    init(networkConfiguration: NetworkConfiguration, endpoint: Endpoint) {
        self.networkConfiguration = networkConfiguration
        self.endpoint = endpoint
    }
    
    func getURL() throws -> URL {
        if let url = URLComponentsBuilder()
            .addHost(networkConfiguration.host)
            .addScheme(networkConfiguration.scheme)
            .appendPath(networkConfiguration.apiBaseRoute)
            .appendPath(endpoint.path)
            .updateQueryItems(networkConfiguration.queryParameters)
            .updateQueryItems(endpoint.queryParameters)
            .exportURL() {
            return url
        }
        throw NetworkingClientSideError.cannotGenerateURL
    }
    
    func getURLRequest() throws -> URLRequest {
        let url = try getURL()
        let urlRequestBuilder = URLRequestBuilder(urlRequest: URLRequest(url: url))
        return try urlRequestBuilder
            .updateHeaderFields(networkConfiguration.headers)
            .updateHeaderFields(endpoint.headerParameters)
            .updateHTTPMethod(endpoint.method)
            .updateHTTPBody(endpoint.bodyParameters, encoder: endpoint.bodyEncoder)
            .exportURLRequest()
    }
}
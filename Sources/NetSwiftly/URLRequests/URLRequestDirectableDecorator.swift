//
//  URLRequestDirectableDecorator.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

class URLRequestDirectableDecorator: URLRequestDirectable {
    
    var endpoint: Endpoint
    var networkConfiguration: NetworkConfiguration
    var urlRequestDirector: URLRequestDirectable
    
    init(urlRequestDirector: URLRequestDirectable) {
        self.urlRequestDirector = urlRequestDirector
        self.endpoint = urlRequestDirector.endpoint
        self.networkConfiguration = urlRequestDirector.networkConfiguration
    }
    
    func getURLRequest() throws -> URLRequest {
        return try urlRequestDirector.getURLRequest()
    }
}

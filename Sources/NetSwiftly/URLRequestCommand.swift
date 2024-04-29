//
//  File.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

class URLRequestCommand: Requestable {
    
    typealias Response = (Data, URLResponse)
    
    let urlRequestDirector: URLRequestDirectable
    let urlSession: URLRequestable
    let urlSessionTaskDelegate: URLSessionTaskDelegate?
    
    init(urlRequestDirector: URLRequestDirectable, 
         urlSession: URLRequestable = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil) {
        self.urlRequestDirector = urlRequestDirector
        self.urlSession = urlSession
        self.urlSessionTaskDelegate = urlSessionTaskDelegate
    }
    
    func request() async throws -> (Data, URLResponse) {
        let urlRequest = try urlRequestDirector.getURLRequest()
        return try await urlSession.data(for: urlRequest, delegate: urlSessionTaskDelegate)
    }
}

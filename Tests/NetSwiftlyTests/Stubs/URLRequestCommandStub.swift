//
//  URLRequestCommandStub.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//
@testable import NetSwiftly
import Foundation

class URLRequestCommandStub: Requestable {
    
    typealias Response = (Data, URLResponse)
    
    let urlRequestDirector: URLRequestDirectable
    let urlSession: URLRequestable
    let urlSessionTaskDelegate: URLSessionTaskDelegate?
    
    let delayInSeconds: Double
    let result: (Data, URLResponse)
    
    init(delayInSeconds: Double,
         result: (Data, URLResponse)) {
        self.delayInSeconds = delayInSeconds
        self.result = result
        self.urlRequestDirector = URLRequestDirectorDummy()
        self.urlSession = URLSession.shared
        self.urlSessionTaskDelegate = nil
    }
    
    func request() async throws -> (Data, URLResponse) {
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        return result
    }
}

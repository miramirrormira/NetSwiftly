//
//  URLSessionStub.swift
//
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public class URLSessionStub: URLSessionAbstractLayer {

    let data: Data
    let response: URLResponse
    let delay: UInt64
    
    init(data: Data, response: URLResponse, delayInSeconds: Double) {
        self.data = data
        self.response = response
        self.delay = UInt64(delayInSeconds * 1000000000.0)
    }
    
    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        try await Task.sleep(nanoseconds: delay)
        return (data, response)
    }
}

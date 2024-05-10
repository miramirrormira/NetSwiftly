//
//  URLRequestCommand.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public class URLRequestCommand<T: Decodable>: Requestable {
    
    public typealias Response = T
    
    public let urlRequestDirector: URLRequestDirectable
    public let urlSession: URLSessionAbstractLayer
    public let urlSessionTaskDelegate: URLSessionTaskDelegate?
    public let responseDecoder: ResponseDecoder
    
    public init(urlRequestDirector: URLRequestDirectable,
         urlSession: URLSessionAbstractLayer = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil,
         responseDecoder: ResponseDecoder = JSONDecoder()) {
        self.urlRequestDirector = urlRequestDirector
        self.urlSession = urlSession
        self.urlSessionTaskDelegate = urlSessionTaskDelegate
        self.responseDecoder = responseDecoder
    }
    
    public func request() async throws -> T {
        let (data, response) = try await executeURLRequest()
        guard let httpResonse = response as? HTTPURLResponse else {
            throw NetworkingServerSideError.invalidServerResponse
        }
        guard 200..<300 ~= httpResonse.statusCode else {
            throw NetworkingServerSideError.httpResponseError(statusCode: httpResonse.statusCode, data: data)
        }
        let decoded: T = try responseDecoder.decode(T.self, from: data)
        return decoded
    }
    
    func executeURLRequest() async throws -> (Data, URLResponse) {
        let urlRequest = try await urlRequestDirector.getURLRequest()
        return try await urlSession.data(for: urlRequest, delegate: urlSessionTaskDelegate)
    }
}

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
    public var responseDecoder: ResponseDecoder?
    
    public init(urlRequestDirector: URLRequestDirectable,
         urlSession: URLSessionAbstractLayer = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil,
         responseDecoder: ResponseDecoder = JSONDecoder()) {
        self.urlRequestDirector = urlRequestDirector
        self.urlSession = urlSession
        self.urlSessionTaskDelegate = urlSessionTaskDelegate
        self.responseDecoder = responseDecoder
    }
    
    //TODO: add test
    public init(urlRequestDirector: URLRequestDirectable,
         urlSession: URLSessionAbstractLayer = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil) where T == Data {
        self.urlRequestDirector = urlRequestDirector
        self.urlSession = urlSession
        self.urlSessionTaskDelegate = urlSessionTaskDelegate
    }
    
    public func request() async throws -> T {
        let (data, response) = try await executeURLRequest()
        guard let httpResonse = response as? HTTPURLResponse else {
            throw NetworkingServerSideError.invalidServerResponse
        }
        guard 200..<300 ~= httpResonse.statusCode else {
            throw NetworkingServerSideError.httpResponseError(statusCode: httpResonse.statusCode, data: data)
        }
        if let responseDecoder = self.responseDecoder {
            return try responseDecoder.decode(T.self, from: data)
        }
        if let data = data as? T {
            return data
        }
        throw NetworkingClientSideError.noResponseValue
    }
    
    func executeURLRequest() async throws -> (Data, URLResponse) {
        let urlRequest = try await urlRequestDirector.getURLRequest()
        return try await urlSession.data(for: urlRequest, delegate: urlSessionTaskDelegate)
    }
}

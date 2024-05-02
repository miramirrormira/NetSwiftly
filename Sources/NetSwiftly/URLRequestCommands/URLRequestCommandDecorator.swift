//
//  URLRequestCommandDecorator.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public class URLRequestCommandDecorator<T>: Requestable {
    
    public typealias Response = T
    
    public var requestable: AnyRequestable<T>
    
    public init(requestable: AnyRequestable<T>) {
        self.requestable = requestable
    }
    
    public func request() async throws -> T {
        try await requestable.request()
    }
}

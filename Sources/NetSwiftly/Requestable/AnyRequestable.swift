//
//  AnyRequestable.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public class AnyRequestable<T>: Requestable {
    
    public typealias Response = T
    
    private let wrappedRequest: () async throws -> T
    
    public init<V: Requestable>(_ requestable: V) where V.Response == T {
        self.wrappedRequest = requestable.request
    }
    
    public func request() async throws -> T {
        try await wrappedRequest()
    }
}

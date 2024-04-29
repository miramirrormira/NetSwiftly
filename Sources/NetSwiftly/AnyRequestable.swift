//
//  AnyRequestable.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

class AnyRequestable<T>: Requestable {
    
    typealias Response = T
    
    private let wrappedRequest: () async throws -> T
    
    init<V: Requestable>(_ requestable: V) where V.Response == T {
        self.wrappedRequest = requestable.request
    }
    
    func request() async throws -> T {
        try await wrappedRequest()
    }
}

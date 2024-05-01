//
//  URLRequestCommandDecorator.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

class URLRequestCommandDecorator<T>: Requestable {
    
    typealias Response = T
    
    var requestable: AnyRequestable<T>
    
    init(requestable: AnyRequestable<T>) {
        self.requestable = requestable
    }
    
    func request() async throws -> T {
        try await requestable.request()
    }
}

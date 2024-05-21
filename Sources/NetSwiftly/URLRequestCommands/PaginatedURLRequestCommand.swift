//
//  PaginatedURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

class PaginatedURLRequestCommand<T: Decodable>: URLRequestCommand<T> {
    
    override func request() async throws -> T {
        guard let requestDirector = super.urlRequestDirector as? PaginatedURLRequestDirector else {
            throw PaginatedURLRequestCommandError.didNotUsePaginatedURLRequestDirector
        }
        do {
            let result = try await super.request()
            requestDirector.shouldUpdateEndpoint = true
            return result
        } catch {
            requestDirector.shouldUpdateEndpoint = false
            throw error
        }
    }
}

enum PaginatedURLRequestCommandError: Error {
    case didNotUsePaginatedURLRequestDirector
}

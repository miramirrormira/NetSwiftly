//
//  PaginatedURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

public class PaginatedURLRequestCommand<T: Decodable>: URLRequestCommand<T> {
    public override func request() async throws -> T {
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

public extension PaginatedURLRequestCommand {
    convenience init(networkConfiguration: NetworkConfiguration,
                     endpoint: Endpoint,
                     paginationQueryStrategy: PaginationQueryStrategy) {
        let baseURLRequestDirector = EndpointURLRequestDirector(networkConfiguration: networkConfiguration, endpoint: endpoint)
        let pagedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirectable: baseURLRequestDirector, paginationQueryStrategy: paginationQueryStrategy)
        self.init(urlRequestDirector: pagedURLRequestDirector)
    }
}

enum PaginatedURLRequestCommandError: Error {
    case didNotUsePaginatedURLRequestDirector
}

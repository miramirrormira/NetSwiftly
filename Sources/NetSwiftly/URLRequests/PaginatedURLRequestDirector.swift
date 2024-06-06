//
//  PaginatedURLRequestable.swift
//
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public class PaginatedURLRequestDirector: URLRequestDirectableDecorator {
    
    let paginationQueryStrategy: PaginationQueryStrategy
    var shouldUpdateEndpoint: Bool = true
    
    public init(urlRequestDirectable: URLRequestDirectable,
         paginationQueryStrategy: PaginationQueryStrategy) {
        self.paginationQueryStrategy = paginationQueryStrategy
        super.init(urlRequestDirectable: urlRequestDirectable)
    }
    
    private func updateEndpoind() async throws {
        guard let urlRequestDirectable = urlRequestDirectable as? EndpointURLRequestDirector else {
            throw NetworkingClientSideError.wrongURLRequestableType
        }
        guard shouldUpdateEndpoint else { return }
        let parameters = try await paginationQueryStrategy.getNextPageQueryParameters()
        for (key, value) in parameters {
            urlRequestDirectable.endpoint.queryParameters[key] = value
        }
    }
    
    public override func getURLRequest() async throws -> URLRequest {
        try await updateEndpoind()
        return try await super.getURLRequest()
    }
}

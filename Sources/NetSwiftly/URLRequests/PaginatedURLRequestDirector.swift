//
//  PageBasedURLRequestDirector.swift
//
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public class PaginatedURLRequestDirector: URLRequestDirectableDecorator {
    
    let paginationQueryStrategy: PaginationQueryStrategy
    var shouldUpdateEndpoint: Bool = true
    
    public init(urlRequestDirector: URLRequestDirectable,
         paginationQueryStrategy: PaginationQueryStrategy) {
        self.paginationQueryStrategy = paginationQueryStrategy
        super.init(urlRequestDirector: urlRequestDirector)
    }
    
    private func updateEndpoind() async throws {
        guard shouldUpdateEndpoint else { return }
        let parameters = try await paginationQueryStrategy.getNextPageQueryParameters()
        for (key, value) in parameters {
            endpoint.queryParameters[key] = value
        }
    }
    
    public override func getURLRequest() async throws -> URLRequest {
        try await updateEndpoind()
        return try await super.getURLRequest()
    }
}

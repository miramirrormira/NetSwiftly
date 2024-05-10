//
//  PageBasedURLRequestDirector.swift
//
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation

public class PaginatedURLRequestDirector: URLRequestDirectableDecorator {
    
    public let paginationQueryStrategy: PaginationQueryStrategy
    
    public init(urlRequestDirector: URLRequestDirectable,
         paginationQueryStrategy: PaginationQueryStrategy) {
        self.paginationQueryStrategy = paginationQueryStrategy
        super.init(urlRequestDirector: urlRequestDirector)
    }
    
    private func updateEndpoind() async throws {
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

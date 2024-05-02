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
    
    private func updateEndpoind() {
        let parameters = paginationQueryStrategy.getNextPageQueryParameters()
        for (key, value) in parameters {
            endpoint.queryParameters[key] = value
        }
    }
    
    public override func getURLRequest() throws -> URLRequest {
        updateEndpoind()
        return try super.getURLRequest()
    }
}

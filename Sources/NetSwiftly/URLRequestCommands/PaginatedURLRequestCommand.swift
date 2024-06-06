//
//  PaginatedURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

public class PaginatedURLRequestCommand<Page: Decodable, Item: Decodable>: URLRequestCommand<Page> {
    
    typealias Response = [Item]
    
    var transform: (Page) -> [Item]
    
    init(transform: @escaping (Page) -> [Item], 
         urlRequestDirector: PaginatedURLRequestDirector,
         urlSession: URLSessionAbstractLayer = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil,
         responseDecoder: ResponseDecoder = JSONDecoder()) {
        self.transform = transform
        super.init(urlRequestDirector: urlRequestDirector, urlSession: urlSession, urlSessionTaskDelegate: urlSessionTaskDelegate, responseDecoder: responseDecoder)
    }
    
    public func request() async throws -> [Item] {
        let page: Page = try await request()
        return transform(page)
    }
    
    public override func request() async throws -> Page {
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
                     paginationQueryStrategy: PaginationQueryStrategy,
                     transform: @escaping (Page) -> [Item]) {
        let baseURLRequestDirector = EndpointURLRequestDirector(networkConfiguration: networkConfiguration, endpoint: endpoint)
        let pagedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirectable: baseURLRequestDirector, paginationQueryStrategy: paginationQueryStrategy)
        self.init(transform: transform, urlRequestDirector: pagedURLRequestDirector)
    }
}

enum PaginatedURLRequestCommandError: Error {
    case didNotUsePaginatedURLRequestDirector
}

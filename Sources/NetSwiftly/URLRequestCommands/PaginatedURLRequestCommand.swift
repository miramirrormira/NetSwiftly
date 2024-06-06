//
//  PaginatedURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

public class PaginatedURLRequestCommand<Page: Decodable, Item: Decodable>: Requestable {
    
    public typealias Response = [Item]
    
    var transform: (Page) -> [Item]
    var urlRequestable: URLRequestCommand<Page>
    
    init(transform: @escaping (Page) -> [Item],
         requestableDirector: PaginatedURLRequestDirector,
         urlSession: URLSessionAbstractLayer = URLSession.shared,
         urlSessionTaskDelegate: URLSessionTaskDelegate? = nil,
         responseDecoder: ResponseDecoder = JSONDecoder()) {
        self.transform = transform
        self.urlRequestable = URLRequestCommand(urlRequestDirector: requestableDirector, urlSession: urlSession, urlSessionTaskDelegate: urlSessionTaskDelegate, responseDecoder: responseDecoder)
    }
    
    public func request() async throws -> [Item] {
        guard let requestDirector = urlRequestable.urlRequestDirector as? PaginatedURLRequestDirector else {
            throw PaginatedURLRequestCommandError.didNotUsePaginatedURLRequestDirector
        }
        do {
            let page = try await urlRequestable.request()
            requestDirector.shouldUpdateEndpoint = true
            return transform(page)
        } catch {
            requestDirector.shouldUpdateEndpoint = false
            throw error
        }
    }
    
//    public override func request() async throws -> Page {
//        guard let requestDirector = super.urlRequestDirector as? PaginatedURLRequestDirector else {
//            throw PaginatedURLRequestCommandError.didNotUsePaginatedURLRequestDirector
//        }
//        do {
//            let result = try await super.request()
//            requestDirector.shouldUpdateEndpoint = true
//            return result
//        } catch {
//            requestDirector.shouldUpdateEndpoint = false
//            throw error
//        }
//    }
}

public extension PaginatedURLRequestCommand {
    convenience init(networkConfiguration: NetworkConfiguration,
                     endpoint: Endpoint,
                     paginationQueryStrategy: PaginationQueryStrategy,
                     transform: @escaping (Page) -> [Item]) {
        let baseURLRequestDirector = EndpointURLRequestDirector(networkConfiguration: networkConfiguration, endpoint: endpoint)
        let pagedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirectable: baseURLRequestDirector, paginationQueryStrategy: paginationQueryStrategy)
        self.init(transform: transform, requestableDirector: pagedURLRequestDirector)
    }
}

enum PaginatedURLRequestCommandError: Error {
    case didNotUsePaginatedURLRequestDirector
}

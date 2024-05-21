//
//  File.swift
//  
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

class PaginatedURLRequestCommandConcreteFactory<ResponseType: Decodable>: RequestableFactory {
    
    var networkConfiguration: NetworkConfiguration
    var endpoint: Endpoint
    var paginationQueryStrategy: PaginationQueryStrategy
    
    init(networkConfiguration: NetworkConfiguration, 
         endpoint: Endpoint,
         paginationQueryStrategy: PaginationQueryStrategy) {
        self.networkConfiguration = networkConfiguration
        self.endpoint = endpoint
        self.paginationQueryStrategy = paginationQueryStrategy
    }
    
    func makeRequestable() -> some Requestable {
        let baseURLRequestDirector = URLRequestDirector(networkConfiguration: networkConfiguration, endpoint: endpoint)
        let pagedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirector: baseURLRequestDirector, paginationQueryStrategy: paginationQueryStrategy)
        return PaginatedURLRequestCommand<ResponseType>(urlRequestDirector: pagedURLRequestDirector)
    }
}

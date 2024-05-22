//
//  File.swift
//
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

public func makePaginatedURLRequestCommand<ResponseType>(networkConfiguration: NetworkConfiguration,
                                                         endpoint: Endpoint,
                                                         paginationQueryStrategy: PaginationQueryStrategy) -> PaginatedURLRequestCommand<ResponseType> {
    
    
    let baseURLRequestDirector = URLRequestDirector(networkConfiguration: networkConfiguration, endpoint: endpoint)
    let pagedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirector: baseURLRequestDirector, paginationQueryStrategy: paginationQueryStrategy)
    return PaginatedURLRequestCommand<ResponseType>(urlRequestDirector: pagedURLRequestDirector)
}

//
//  URLSessionAbstractLayer.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation
protocol URLSessionAbstractLayer {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}


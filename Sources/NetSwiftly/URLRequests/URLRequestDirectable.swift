//
//  URLRequestDirectable.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation
public protocol URLRequestDirectable {
    var endpoint: Endpoint { get set }
    var networkConfiguration: NetworkConfiguration { get set }
    func getURLRequest() throws -> URLRequest
}

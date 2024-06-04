//
//  URLRequestDirectable.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

import Foundation
public protocol URLRequestDirectable {
    func getURLRequest() async throws -> URLRequest
}

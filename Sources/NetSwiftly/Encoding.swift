//
//  Encoding.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) throws -> Data
}

/// Convert parameters to JSON data
public struct JSONBodyEncoder: BodyEncoder {
    public init() {}
    public func encode(_ parameters: [String : Any]) throws -> Data {
        return try JSONSerialization.data(withJSONObject: parameters)
    }
}

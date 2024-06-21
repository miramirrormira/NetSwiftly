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

public extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        if let jsonData = jsonData as? [String : Any] {
            return jsonData
        }
        throw EncodingErrors.cannotConvertToDictionary
    }
}

enum EncodingErrors: Error {
    case cannotConvertToDictionary
}

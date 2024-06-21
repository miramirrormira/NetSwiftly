//
//  ResponseDecoder.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: ResponseDecoder { }

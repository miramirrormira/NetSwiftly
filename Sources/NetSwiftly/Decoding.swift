//
//  File 2.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: ResponseDecoder { }

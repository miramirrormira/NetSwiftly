//
//  TestStruct.swift
//
//
//  Created by Mira Yang on 4/30/24.
//

import Foundation

struct TestStruct: Codable, Equatable {
    var name: String
    var value: Int
    
    init(name: String = "name", value: Int = 123) {
        self.name = name
        self.value = value
    }
}

//
//  TestStruct.swift
//
//
//  Created by Mira Yang on 4/30/24.
//

import Foundation

struct TestStruct: Codable, Equatable, Identifiable {
    var name: String
    var value: Int
    var id: String {
        name + "\(value)"
    }
    
    init(name: String = "name", value: Int = 123) {
        self.name = name
        self.value = value
    }
}

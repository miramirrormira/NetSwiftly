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
    
    public init(name: String = "name", value: Int = 123) {
        self.name = name
        self.value = value
    }
}

struct Page: Identifiable, Codable {
    var id: String
    var items: [Item]
}

struct Item: Identifiable, Codable {
    var id: String
}

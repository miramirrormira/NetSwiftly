//
//  RequestableDummy.swift
//
//
//  Created by Mira Yang on 5/13/24.
//

import Foundation

class RequestableDummy<T>: Requestable {
    typealias Response = T
    
    func request() async throws -> T {
        fatalError()
    }
}

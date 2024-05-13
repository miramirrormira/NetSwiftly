//
//  PaginationQueryStrategyStub.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//
import Foundation

class PaginationQueryStrategyStub: PaginationQueryStrategy {
    let result: [String: Int]
    init(result: [String : Int]) {
        self.result = result
    }
    func getNextPageQueryParameters() -> [String : Int] {
        result
    }
}

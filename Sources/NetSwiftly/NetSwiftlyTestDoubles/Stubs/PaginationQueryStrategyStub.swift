//
//  PaginationQueryStrategyStub.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//
import Foundation

public class PaginationQueryStrategyStub: PaginationQueryStrategy {
    let result: [String: Int]
    init(result: [String : Int]) {
        self.result = result
    }
    public func getNextPageQueryParameters() -> [String : Int] {
        result
    }
}

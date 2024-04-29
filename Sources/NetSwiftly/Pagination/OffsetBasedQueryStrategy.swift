//
//  File.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

class OffsetBasedQueryStrategy: PaginationQueryStrategy {
    
    let offsetKey: String
    var currentOffset: Int
    let limitKey: String
    let limit: Int
    
    init(offsetKey: String, 
         currentOffset: Int = 0,
         limitKey: String,
         limit: Int) {
        self.offsetKey = offsetKey
        self.currentOffset = currentOffset
        self.limitKey = limitKey
        self.limit = limit
    }
    
    private func updateCurrentOffset() {
        currentOffset += limit
    }
    
    func getNextPageQueryParameters() -> [String : Int] {
        updateCurrentOffset()
        var result = [String: Int]()
        result[offsetKey] = currentOffset
        result[limitKey] = limit
        return result
    }
}

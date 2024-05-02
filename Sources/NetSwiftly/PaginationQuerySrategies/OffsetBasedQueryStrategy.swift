//
//  OffsetBasedQueryStrategy.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

public class OffsetBasedQueryStrategy: PaginationQueryStrategy {
    
    public let offsetKey: String
    public var currentOffset: Int
    public let limitKey: String
    public let limit: Int
    
    public init(offsetKey: String, 
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
    
    public func getNextPageQueryParameters() -> [String : Int] {
        updateCurrentOffset()
        var result = [String: Int]()
        result[offsetKey] = currentOffset
        result[limitKey] = limit
        return result
    }
}

//
//  OffsetBasedQueryStrategy.swift
//
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

public class OffsetBasedQueryStrategy: PaginationQueryStrategy {
    
    private let offsetKey: String
    public var currentOffset: Int
    private let limitKey: String
    private let limit: Int
    private let threadSafetyQueue: DispatchQueue
    
    public init(offsetKey: String,
                currentOffset: Int = 0,
                limitKey: String,
                limit: Int,
                threadSafetyQueue: DispatchQueue = .global(qos: .background)) {
        self.offsetKey = offsetKey
        self.currentOffset = currentOffset
        self.limitKey = limitKey
        self.limit = limit
        self.threadSafetyQueue = threadSafetyQueue
    }
    
    private func updateCurrentOffset() async -> Int {
        await withCheckedContinuation { continuation in
            threadSafetyQueue.async(flags: .barrier) {
                self.currentOffset += self.limit
                continuation.resume(returning: self.currentOffset)
            }
        }
    }
    
    public func getNextPageQueryParameters() async throws -> [String : Int] {
        let currentOffset = await updateCurrentOffset()
        var result = [String: Int]()
        result[offsetKey] = currentOffset
        result[limitKey] = limit
        return result
    }
}

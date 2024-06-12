//
//  CachedRequestableDecorator.swift
//
//
//  Created by Mira Yang on 6/8/24.
//

import Foundation
import CacheSwiftly

public class CachedRequestableDecorator<T>: RequestableDecorator<T> {
    public let cache: Cache<Task<T, Error>>
    public let key: Cache.Key
    public let calculateCost: ((Task<T, Error>) -> Int)
    
    public init(cache: Cache<Task<T, Error>>,
                key: Cache.Key,
                calculateCost: @escaping ((Task<T, Error>) -> Int) = { _ in 1},
                requestable: AnyRequestable<T>) {
        self.cache = cache
        self.key = key
        self.calculateCost = calculateCost
        super.init(requestable: requestable)
    }
    
    public override func request() async throws -> T {
        if let cachedTask = cache[key] {
            return try await cachedTask.value
        }
        let task = Task {
            return try await super.request()
        }
        try cache.setValue(task, forKey: key, cost: calculateCost(task))
        return try await task.value
    }
}

//
//  CachedTaskRequestableDecorator.swift
//
//
//  Created by Mira Yang on 6/8/24.
//

import Foundation
import CacheSwiftly

public class CachedTaskRequestableDecorator<T>: RequestableDecorator<T> {
    public let cache: AnyCachable<Task<T, Error>>
    public let key: AnyCachable.Key
    public let calculateCost: ((Task<T, Error>) -> Int)
    
    public init(cache: AnyCachable<Task<T, Error>>,
                key: AnyCachable.Key,
                calculateCost: @escaping ((Task<T, Error>) -> Int) = { _ in 1},
                requestable: AnyRequestable<T>) {
        self.cache = cache
        self.key = key
        self.calculateCost = calculateCost
        super.init(requestable: requestable)
    }
    
    public override func request() async throws -> T {
        if let cachedTask = try await cache[key] {
            return try await cachedTask.value
        }
        let task = Task {
            return try await super.request()
        }
        try cache.setValue(task, forKey: key, cost: calculateCost(task))
        return try await task.value
    }
}

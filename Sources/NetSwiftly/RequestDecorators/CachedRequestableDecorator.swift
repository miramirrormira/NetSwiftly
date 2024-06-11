//
//  CachedRequestableDecorator.swift
//
//
//  Created by Mira Yang on 6/8/24.
//

import Foundation
import CacheSwiftly

public class CachedRequestableDecorator<T>: RequestableDecorator<T> {
    public let cache: Cache<T>
    public let key: Cache.Key
    public let calculateCost: ((T) -> Int)
    var task: Task<T, Error>?
    let threadSafetyQueue = DispatchQueue(label: "NetSwiftly.CachedRequestableDecorator.threadSafetyQueue", 
                                          attributes: [.concurrent],
                                          target: .global(qos: .background))
    
    public var safeTask: Task<T, Error>? {
        threadSafetyQueue.sync {
            task
        }
    }
    
    public init(cache: Cache<T>,
                key: Cache.Key,
                calculateCost: @escaping ((T) -> Int) = { _ in 1},
                requestable: AnyRequestable<T>) {
        self.cache = cache
        self.key = key
        self.calculateCost = calculateCost
        super.init(requestable: requestable)
    }
    
    public override func request() async throws -> T {
        if let cached = cache[key] {
            return cached
        }
        if safeTask != nil {
            return try await safeTask!.value
        }
        createTask()
        let response = try await safeTask!.value
        try cache.setValue(response, forKey: key, cost: calculateCost(response))
        return response
    }
    
    func createTask() {
        threadSafetyQueue.sync(flags: .barrier) {
            if task == nil {
                task = Task {
                    return try await super.request()
                }
            }
        }
    }
}

//
//  CachedRequestableDecorator.swift
//
//
//  Created by Mira Yang on 6/15/24.
//

import Foundation
import CacheSwiftly

public class CachedRequestableDecorator<T>: RequestableDecorator<T> {
    public let cache: AnyCachable<T>
    public let key: AnyCachable.Key
    public let calculateCost: ((T) -> Int)
    
    public init(cache: AnyCachable<T>,
                key: AnyCachable.Key,
                calculateCost: @escaping ((T) -> Int) = { _ in 1},
                requestable: AnyRequestable<T>) {
        self.cache = cache
        self.key = key
        self.calculateCost = calculateCost
        super.init(requestable: requestable)
    }
    
    public override func request() async throws -> T {
        if let cached = try await cache[key] {
            return cached
        }
        let response = try await super.request()
        try cache.setValue(response, forKey: key, cost: calculateCost(response))
        return response
    }
}

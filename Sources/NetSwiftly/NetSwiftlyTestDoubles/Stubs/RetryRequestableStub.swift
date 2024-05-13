//
//  RetryRequestableStub.swift
//
//
//  Created by Mira Yang on 5/1/24.
//

import Foundation

public class RetryRequestableStub<T>: Requestable {
    
    public typealias Response = T
   
    let delayInSeconds: Double
    let result: T?
    var errors: [Error] = []
    var count = 0
    
    public init(delayInSeconds: Double = 0.5,
         retriedErrors: [Error],
         endWithResult: T? = nil) {
        self.delayInSeconds = delayInSeconds
        self.result = endWithResult
        self.errors = retriedErrors
    }
    
    public func request() async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        if errors.count > count {
            let index = count
            count += 1
            throw errors[index]
        } else if let result = result {
            return result
        }
        fatalError()
    }
}

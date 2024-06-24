//
//  URLRequestCommandStub.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//
import Foundation

public class RequestableStub<T>: Requestable {
    
    public typealias Response = T
    private let delayInSeconds: Double
    private(set) var result: T?
    private(set) var error: Error?
    
    public init(delayInSeconds: Double = 0.0,
                returning result: T) {
        self.delayInSeconds = delayInSeconds
        self.result = result
    }
    
    public init(delayInSeconds: Double = 0.0,
                error: Error) {
        self.delayInSeconds = delayInSeconds
        self.error = error
    }
    
    public func request() async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        if let result = self.result {
            return result
        } else {
            if error == nil {
                fatalError()
            }
            throw error!
        }
    }
}

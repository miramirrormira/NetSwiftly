//
//  URLRequestCommandStub.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//
@testable import NetSwiftly
import Foundation

class RequestableStub<T>: Requestable {
    
    typealias Response = T
   
    let delayInSeconds: Double
    var result: [T] = []
    var error: Error?
    var count = 0
    
    init(delayInSeconds: Double = 0.5,
         result: T) {
        self.delayInSeconds = delayInSeconds
        self.result = [result]
    }
    
    init(delayInSeconds: Double = 0.5,
         error: Error) {
        self.delayInSeconds = delayInSeconds
        self.error = error
    }
    
    init(delayInSeconds: Double = 0.5,
         retriedResults: [T],
         endWithError: Error) {
        self.delayInSeconds = delayInSeconds
        self.result = retriedResults
        self.error = endWithError
    }
    
    func request() async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        if result.count > count {
            let index = count
            count += 1
            return result[index]
        } else if let error = error {
            throw error
        }
        fatalError()
    }
}

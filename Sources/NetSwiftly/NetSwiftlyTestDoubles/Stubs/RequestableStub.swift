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
    private(set) var results: [T] = []
    private(set) var error: Error?
    private var count = 0
    private let countQueue = DispatchQueue(label: "count-thread-safty-serial-queue")
    
    init(delayInSeconds: Double = 0.5,
         returning result: T) {
        self.delayInSeconds = delayInSeconds
        self.results = [result]
    }
    
    init(delayInSeconds: Double = 0.5,
         error: Error) {
        self.delayInSeconds = delayInSeconds
        self.error = error
    }
    
    init(delayInSeconds: Double = 0.5,
         returning results: [T],
         endWith error: Error? = nil) {
        self.delayInSeconds = delayInSeconds
        self.results = results
        self.error = error
    }
    
    public func request() async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        return try await withCheckedThrowingContinuation { continuation in
            countQueue.async { [weak self] in
                guard let strongSelf = self else {
                    continuation.resume(throwing: RequestableStubErrors.selfNotCaptured)
                    return
                }
                if strongSelf.results.count > strongSelf.count {
                    let index = strongSelf.count
                    strongSelf.count += 1
                    continuation.resume(returning: strongSelf.results[index])
                } else {
                    continuation.resume(throwing: RequestableStubErrors.reachedLastResultsElement)
                }
            }
        }
    }
    
    enum RequestableStubErrors: Error {
        case selfNotCaptured
        case reachedLastResultsElement
    }
}

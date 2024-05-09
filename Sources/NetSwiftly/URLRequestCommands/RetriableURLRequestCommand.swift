//
//  RetriableURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/1/24.
//

import Foundation

public class RetriableURLRequestCommand<T>: RequestableDecorator<T> {
    
    public let retry: Int
    public let delayInSeconds: Double
    public var tryCount: Int = 0
    public let retriableHTTPStatusCodes: Set<Int>
    
    public init(retry: Int,
         delayInSeconds: Double = 0,
         requestable: AnyRequestable<T>,
         retriableHTTPStatusCodes: Set<Int> = [429, 503]) {
        self.retry = retry
        self.delayInSeconds = delayInSeconds
        self.retriableHTTPStatusCodes = retriableHTTPStatusCodes
        super.init(requestable: requestable)
    }
    
    public override func request() async throws -> T {
        while tryCount < retry {
            tryCount += 1
            do {
                let result = try await super.request()
                return result
            } catch NetworkingServerSideError.httpResponseError(let statusCode, let data) {
                guard retriableHTTPStatusCodes.contains(statusCode) else {
                    throw NetworkingServerSideError.httpResponseError(statusCode: statusCode, data: data)
                }
                try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
                continue
            } catch {
                throw error
            }
        }
        throw NetworkingServerSideError.noServerResponse
    }
}

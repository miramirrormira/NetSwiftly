//
//  RetriableURLRequestCommand.swift
//
//
//  Created by Mira Yang on 5/1/24.
//

import Foundation

class RetriableURLRequestCommand<T>: URLRequestCommandDecorator<T> {
    
    let retry: Int
    let delayInSeconds: Double
    var tryCount: Int = 0
    init(retry: Int,
         delayInSeconds: Double = 0,
         requestable: AnyRequestable<T>) {
        self.retry = retry
        self.delayInSeconds = delayInSeconds
        super.init(requestable: requestable)
    }
    
    override func request() async throws -> T {
        while tryCount < retry {
            tryCount += 1
            do {
                let result = try await super.request()
                return result
            } catch NetworkingServerSideError.httpResponseError(let statusCode, let data) {
                guard retriableHTTPStatusCode.contains(statusCode) else {
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

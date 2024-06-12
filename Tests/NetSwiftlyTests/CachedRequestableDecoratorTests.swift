@testable import NetSwiftly
import CacheSwiftly
import XCTest

final class CachedRequestableDecoratorTests: XCTestCase {

    func test_request_shouldTriggeredCalculateCost() async throws {
        let cache = Cache<Task<Int, any Error>>(costLimit: 10)
        var triggered = false
        let calculateCost: (Task<Int, any Error>) -> Int = { _ in
            triggered = true
            return -1
        }
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", calculateCost: calculateCost, requestable: requestable)
        _ = try await sut.request()
        XCTAssertTrue(triggered)
    }
    
    func test_request_return0_shouldCacheResult() async throws {
        let cache = Cache<Task<Int, any Error>>(costLimit: 10)
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", requestable: requestable)
        _ = try await sut.request()
        let cached = try await cache["key"]?.value
        XCTAssertEqual(cached, 0)
    }
    
    
    func test_request_return0then1_shouldReturn0TwiceDueToCaching() async throws {
        let cache = Cache<Task<Int, any Error>>(costLimit: 10)
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", requestable: requestable)
        let firstResult = try await sut.request()
        XCTAssertEqual(firstResult, 0)
        sut.requestable = AnyRequestable(RequestableStub<Int>(returning: 1))
        let secondResult = try await sut.request()
        XCTAssertEqual(secondResult, 0)
    }
}

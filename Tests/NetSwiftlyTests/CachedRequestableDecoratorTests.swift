@testable import NetSwiftly
import CacheSwiftly
import XCTest

final class CachedRequestableDecoratorTests: XCTestCase {

    func test_request_shouldTriggeredCalculateCost() async throws {
        let cache = Cache<Int>(costLimit: 10)
        var triggered = false
        let calculateCost: (Int) -> Int = { _ in
            triggered = true
            return -1
        }
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", calculateCost: calculateCost, requestable: requestable)
        _ = try await sut.request()
        XCTAssertTrue(triggered)
    }
    
    func test_request_return0_shouldCacheResult() async throws {
        let cache = Cache<Int>(costLimit: 10)
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", requestable: requestable)
        _ = try await sut.request()
        let cached = cache["key"]
        XCTAssertEqual(cached, 0)
    }
    
    
    func test_request_return0then1_shouldReturn0TwiceDueToCaching() async throws {
        let cache = Cache<Int>(costLimit: 10)
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        let sut = CachedRequestableDecorator(cache: cache, key: "key", requestable: requestable)
        let firstResult = try await sut.request()
        XCTAssertEqual(firstResult, 0)
        sut.requestable = AnyRequestable(RequestableStub<Int>(returning: 1))
        let secondResult = try await sut.request()
        XCTAssertEqual(secondResult, 0)
    }
    
    func test_request_raceCondition() async throws {
        let count = 1000
        let cache = Cache<Int>(costLimit: 5)
        let requestable = AnyRequestable(RequestableStub<Int>(returning: 0))
        
        let sut = CachedRequestableDecorator(cache: cache, key: "key", requestable: requestable)
        
        for _ in 0..<count {
            await withThrowingTaskGroup(of: Int.self) { group in
                group.addTask {
                    try await sut.request()
                }
            }
        }
    }
}

@testable import NetSwiftly
import XCTest

final class OffsetBasedQueryStrategyTests: XCTestCase {

    func test_updateCurrentOffset_indirectly_should_increase_by_limit() async throws {
        let strategy = OffsetBasedQueryStrategy.fixture(offsetKey: "offset", limit: 10)
        XCTAssertEqual(strategy.currentOffset, 0)
        let _ = try await strategy.getNextPageQueryParameters()
        XCTAssertEqual(strategy.currentOffset, 10)
    }
    
    func test_initialization_currentOffset_should_be_zero() {
        let strategy = OffsetBasedQueryStrategy.fixture()
        XCTAssertEqual(strategy.currentOffset, 0)
    }
    
    func test_getNextPageQueryParameters_should_have_both_offset_and_limit_key_value_pairs() async throws {
        let strategy = OffsetBasedQueryStrategy.fixture(offsetKey: "offset", limitKey: "limit", limit: 10)
        
        let result = try await strategy.getNextPageQueryParameters()
        XCTAssertNotNil(result["offset"])
        XCTAssertNotNil(result["limit"])
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result["limit"], 10)
    }
    
    func test_getNextPageQueryParameters_offset_should_start_from_zero() async throws {
        let strategy = OffsetBasedQueryStrategy.fixture(offsetKey: "offset")
        let offset = try await strategy.getNextPageQueryParameters()["offset"]!
        let unwrappedOffset = try XCTUnwrap(offset)
        XCTAssertEqual(unwrappedOffset, 0)
    }
    
    func test_getNextPageQueryParameters_offset_should_increase_by_limit() async throws {
        let strategy = OffsetBasedQueryStrategy.fixture(offsetKey: "offset")
        
        let offset1 = try await strategy.getNextPageQueryParameters()["offset"]!
        let offset2 = try await strategy.getNextPageQueryParameters()["offset"]!
        let unwrappedOffset1 = try XCTUnwrap(offset1)
        let unwrappedOffset2 = try XCTUnwrap(offset2)
        XCTAssertEqual(unwrappedOffset1 + 10, unwrappedOffset2)
    }
}

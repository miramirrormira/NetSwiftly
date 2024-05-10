@testable import NetSwiftly
import XCTest

final class PageBasedQueryStrategyTests: XCTestCase {

    func test_updateCurrentPage_indirectly_should_increase_by_one() async throws {
        let strategy = PageBasedQueryStrategy.fixture()
        let oldCurrentPageValue = strategy.currentPage
        let _ = try await strategy.getNextPageQueryParameters()
        XCTAssertEqual(strategy.currentPage, oldCurrentPageValue + 1)
    }
    
    func test_initialization_currentPage_should_be_zero() {
        let strategy = PageBasedQueryStrategy.fixture()
        XCTAssertEqual(strategy.currentPage, 0)
    }
    
    func test_getNextPageQueryParameters_should_have_page_key_value_pair() async throws {
        let strategy = PageBasedQueryStrategy.fixture(pageKey: "page")
        let result = try await strategy.getNextPageQueryParameters()
        XCTAssertNotNil(result["page"])
        XCTAssertEqual(result.count, 1)
    }
    
    func test_getNextPageQueryParameters_should_have_page_size_key_value_pair() async throws {
        let strategy = PageBasedQueryStrategy.fixture(pageSizeInfo: ("pageSize", 10))
        let result = try await strategy.getNextPageQueryParameters()
        XCTAssertNotNil(result["pageSize"])
        XCTAssertEqual(result.count, 2)
    }
    
    func test_getNextPageQueryParameters_result_page_should_increase_by_one() async throws {
        let strategy = PageBasedQueryStrategy.fixture(pageKey: "page")
        var pageNumber1 = try await strategy.getNextPageQueryParameters()["page"]
        var pageNumber2 = try await strategy.getNextPageQueryParameters()["page"]
        let unwrappedPageNumber1 = try XCTUnwrap(pageNumber1)
        let unwrappedPageNumber2 = try XCTUnwrap(pageNumber2)
        XCTAssertEqual(unwrappedPageNumber1 + 1, unwrappedPageNumber2)
    }
}

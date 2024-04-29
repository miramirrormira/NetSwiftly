@testable import NetSwiftly
import XCTest

final class PageBasedQueryStrategyTests: XCTestCase {

    func test_updateCurrentPage_indirectly_should_increase_by_one() {
        let strategy = PageBasedQueryStrategy.fixture()
        let oldCurrentPageValue = strategy.currentPage
        let _ = strategy.getNextPageQueryParameters()
        XCTAssertEqual(strategy.currentPage, oldCurrentPageValue + 1)
    }
    
    func test_initialization_currentPage_should_be_zero() {
        let strategy = PageBasedQueryStrategy.fixture()
        XCTAssertEqual(strategy.currentPage, 0)
    }
    
    func test_getNextPageQueryParameters_should_have_page_key_value_pair() {
        let strategy = PageBasedQueryStrategy.fixture(pageKey: "page")
        let result = strategy.getNextPageQueryParameters()
        XCTAssertNotNil(result["page"])
        XCTAssertEqual(result.count, 1)
    }
    
    func test_getNextPageQueryParameters_should_have_page_size_key_value_pair() {
        let strategy = PageBasedQueryStrategy.fixture(pageSizeInfo: ("pageSize", 10))
        let result = strategy.getNextPageQueryParameters()
        XCTAssertNotNil(result["pageSize"])
        XCTAssertEqual(result.count, 2)
    }
    
    func test_getNextPageQueryParameters_result_page_should_increase_by_one() throws {
        let strategy = PageBasedQueryStrategy.fixture(pageKey: "page")
        let pageNumber1 = try XCTUnwrap(strategy.getNextPageQueryParameters()["page"])
        let pageNumber2 = try XCTUnwrap(strategy.getNextPageQueryParameters()["page"])
        XCTAssertEqual(pageNumber1 + 1, pageNumber2)
    }
}

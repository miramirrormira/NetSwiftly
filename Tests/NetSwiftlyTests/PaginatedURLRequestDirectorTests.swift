@testable import NetSwiftly
import XCTest

final class PaginatedURLRequestDirectorTests: XCTestCase {

    func test_updateEndpoint_indirectly_endpoint_should_have_page_query_parameters() async throws {
        let strategyStub = PaginationQueryStrategyStub(result: ["page" : 5])
        let urlRequestDirector = URLRequestDirectorDummy()
        let paginatedURLRequestDirector = PaginatedURLRequestDirector(urlRequestDirector: urlRequestDirector, paginationQueryStrategy: strategyStub)
        let _ = try await paginatedURLRequestDirector.getURLRequest()
        XCTAssertEqual(paginatedURLRequestDirector.endpoint.queryParameters["page"] as? Int, 5)
    }
}

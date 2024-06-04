@testable import NetSwiftly
import XCTest

final class PaginatedURLRequestableTests: XCTestCase {

    func test_updateEndpoint_endpoint_should_have_page_query_parameters() async throws {
        let strategyStub = PaginationQueryStrategyStub(result: ["page" : 5])
        let urlRequestDirector = EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture())
        let sut = PaginatedURLRequestDirector(urlRequestDirectable: urlRequestDirector, paginationQueryStrategy: strategyStub)
        let _ = try await sut.getURLRequest()
        
        XCTAssertEqual(urlRequestDirector.endpoint.queryParameters["page"] as? Int, 5)
    }
    
    func test_updateEndpoint_with_shouldUpdateEndpoint_equal_to_false_endpoint_should_not_have_page_query_parameters() async throws {
        let strategyStub = PaginationQueryStrategyStub(result: ["page" : 5])
        let urlRequestDirector = EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture())
        let sut = PaginatedURLRequestDirector(urlRequestDirectable: urlRequestDirector, paginationQueryStrategy: strategyStub)
        sut.shouldUpdateEndpoint = false
        let _ = try await sut.getURLRequest()
        XCTAssertNil(urlRequestDirector.endpoint.queryParameters["page"])
    }
    
    func test_updateEndpoint_with_shouldUpdateEndpoint_equal_to_false_endpoint_should_not_have_new_page_number() async throws {
        let strategyStub = PaginationQueryStrategyStub(result: ["page" : 5])
        let urlRequestDirector = EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture())
        let sut = PaginatedURLRequestDirector(urlRequestDirectable: urlRequestDirector, paginationQueryStrategy: strategyStub)
        let _ = try await sut.getURLRequest()
        XCTAssertEqual(urlRequestDirector.endpoint.queryParameters["page"] as? Int, 5)
        strategyStub.result["page"] = 6
        sut.shouldUpdateEndpoint = false
        let _ = try await sut.getURLRequest()
        XCTAssertEqual(urlRequestDirector.endpoint.queryParameters["page"] as? Int, 5)
    }
    
    func test_updateEndpoint_with_shouldUpdateEndpoint_equal_to_true_endpoint_should_not_have_new_page_number() async throws {
        let strategyStub = PaginationQueryStrategyStub(result: ["page" : 5])
        let urlRequestDirector = EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture())
        let sut = PaginatedURLRequestDirector(urlRequestDirectable: urlRequestDirector, paginationQueryStrategy: strategyStub)
        let _ = try await sut.getURLRequest()
        XCTAssertEqual(urlRequestDirector.endpoint.queryParameters["page"] as? Int, 5)
        strategyStub.result["page"] = 6
        let _ = try await sut.getURLRequest()
        XCTAssertEqual(urlRequestDirector.endpoint.queryParameters["page"] as? Int, 6)
    }
}

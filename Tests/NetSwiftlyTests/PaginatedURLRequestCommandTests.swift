@testable import NetSwiftly
import XCTest

final class PaginatedURLRequestCommandTests: XCTestCase {
    
    

    func test_with_failure_case_shouldUpdateEndpoint_should_be_false_after_request() async throws {
        let page = Page(id: "0", items: [Item(id: "0")])
        let data = try JSONEncoder().encode(page)
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(data: data, statusCode: 500)
        let director = PaginatedURLRequestDirector(urlRequestDirectable: EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture()), paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"))
        let sut = PaginatedURLRequestCommand<Page, Item>(transform: { $0.items }, requestableDirector: director, urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        XCTAssertTrue(director.shouldUpdateEndpoint)
        let _ = try? await sut.request()
        XCTAssertFalse(director.shouldUpdateEndpoint)
    }
    
    func test_with_success_case_shouldUpdateEndpoint_should_be_true_after_request() async throws {
        let testStruct = Page(id: "0", items: [Item(id: "0")])
        let data = try JSONEncoder().encode(testStruct)
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(data: data)
        let director = PaginatedURLRequestDirector(urlRequestDirectable: EndpointURLRequestDirector(networkConfiguration: .fixture(), endpoint: .fixture()), paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"))
        let sut = PaginatedURLRequestCommand<Page, Item>(transform: { $0.items }, requestableDirector: director, urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        XCTAssertTrue(director.shouldUpdateEndpoint)
        let _ = try await sut.request()
        XCTAssertTrue(director.shouldUpdateEndpoint)
    }
    
    func test_convinient_init_with_networkConfiguration_endpoint_paginationQueryStrategy() {
        let networkConfiguration = NetworkConfiguration.fixture()
        let endpoint = Endpoint.fixture()
        let paginationQueryStrategy = PageBasedQueryStrategy.fixture()
        
        let sut: PaginatedURLRequestCommand<Page, Item> = .init(networkConfiguration: networkConfiguration, endpoint: endpoint, paginationQueryStrategy: paginationQueryStrategy, transform: { $0.items })
        
        guard let paginatedURLRequestDirector = sut.urlRequestable.urlRequestDirector as? PaginatedURLRequestDirector else {
            XCTFail("wrong urlRequestDirector type")
            return
        }
        
        guard let paginationQueryStrategyInSut = paginatedURLRequestDirector.paginationQueryStrategy as? PageBasedQueryStrategy else {
            XCTFail("wrong paginationQueryStrategy type")
            return
        }
        XCTAssertIdentical(paginationQueryStrategyInSut, paginationQueryStrategy)
    }
}

@testable import NetSwiftly
import XCTest

final class PaginatedURLRequestCommandTests: XCTestCase {

    func test_with_failure_case_shouldUpdateEndpoint_should_be_false_after_request() async throws {
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(statusCode: 500)
        let director = PaginatedURLRequestDirector(urlRequestDirector: URLRequestDirectorFake(), paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"))
        let sut = PaginatedURLRequestCommand<[Int]>(urlRequestDirector: director, urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        XCTAssertTrue(director.shouldUpdateEndpoint)
        let _ = try? await sut.request()
        XCTAssertFalse(director.shouldUpdateEndpoint)
    }
    
    func test_with_success_case_shouldUpdateEndpoint_should_be_true_after_request() async throws {
        let testStruct = TestStruct(name: "name")
        let data = try JSONEncoder().encode(testStruct)
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(data: data)
        let director = PaginatedURLRequestDirector(urlRequestDirector: URLRequestDirectorFake(), paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"))
        let sut = PaginatedURLRequestCommand<TestStruct>(urlRequestDirector: director, urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        XCTAssertTrue(director.shouldUpdateEndpoint)
        let _ = try await sut.request()
        XCTAssertTrue(director.shouldUpdateEndpoint)
    }
    
    func test_with_wrong_URLRequestDirector_should_throw_error() async throws {
        
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse()
        let director = URLRequestDirectorFake()
        let sut = PaginatedURLRequestCommand<TestStruct>(urlRequestDirector: director, urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        
        do {
            let _ = try await sut.request()
        } catch let error as PaginatedURLRequestCommandError {
            XCTAssertEqual(error, PaginatedURLRequestCommandError.didNotUsePaginatedURLRequestDirector)
        } catch {
            XCTFail("wrong error")
        }
    }
}

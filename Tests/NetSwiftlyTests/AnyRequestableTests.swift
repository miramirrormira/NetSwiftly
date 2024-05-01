@testable import NetSwiftly
import XCTest

final class AnyRequestableTests: XCTestCase {

    func test_wrappedRequest() async throws {
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse()
        let requestableStub = RequestableStub(delayInSeconds: 0.5, result: (urlRequestResponse.data, urlRequestResponse.response))
        let anyRequest = AnyRequestable(requestableStub)
        let result = try await anyRequest.request()
        XCTAssertEqual(result.0, urlRequestResponse.data)
        XCTAssertEqual(result.1, urlRequestResponse.response)
    }
}

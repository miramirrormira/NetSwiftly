@testable import NetSwiftly
import XCTest

final class AnyRequestableTests: XCTestCase {

    func test_wrappedRequest() async throws {
        let urlRequestResponse = try URLRequestResponse.fixture()
        let urlRequestCommandStub = URLRequestCommandStub(delayInSeconds: 0.5, result: (urlRequestResponse.data, urlRequestResponse.response))
        let anyRequest = AnyRequestable(urlRequestCommandStub)
        let result = try await anyRequest.request()
        XCTAssertEqual(result.0, urlRequestResponse.data)
        XCTAssertEqual(result.1, urlRequestResponse.response)
    }
}

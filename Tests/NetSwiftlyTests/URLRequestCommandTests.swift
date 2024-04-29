@testable import NetSwiftly
import XCTest

final class URLRequestCommandTests: XCTestCase {

    func test_request_should_execute_urlSession_functions() async throws {
        let urlRequestResponse = try URLRequestResponse.fixture()
        let urlRequestCommand = URLRequestCommand(urlRequestDirector: URLRequestDirectorDummy(),
                                                  urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        let (outputData, outputResponse) = try await urlRequestCommand.request()
        XCTAssertEqual(urlRequestResponse.data, outputData)
        XCTAssertEqual(urlRequestResponse.response, outputResponse)
    }
}

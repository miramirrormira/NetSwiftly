@testable import NetSwiftly
import XCTest

final class RetriableURLRequestCommandTests: XCTestCase {

    func test_request_with_three_retries_and_success_case() async throws {
        let requestableStub = RetryRequestableStub(retriedErrors: [], endWithResult: 0)
        let retriableCommand = RetriableURLRequestCommand<Int>(retry: 3, requestable: AnyRequestable(requestableStub))
        do {
            let result = try await retriableCommand.request()
            XCTAssertEqual(result, 0)
        } catch {
            XCTFail("should not throw an error: \(error.localizedDescription)")
        }
        XCTAssertEqual(retriableCommand.tryCount, 1)
    }
    
    func test_request_with_three_retries_one_retriable_error_then_success_case_should_get_success_result() async throws {
        let retriableHTTPError = NetworkingServerSideError.httpResponseError(statusCode: 123, data: nil)
        let requestableStub = RetryRequestableStub(retriedErrors: [retriableHTTPError], endWithResult: 0)
        let retriableCommand = RetriableURLRequestCommand<Int>(retry: 3, requestable: AnyRequestable(requestableStub), retriableHTTPStatusCodes: [123])
        do {
            let result = try await retriableCommand.request()
            XCTAssertEqual(result, 0)
        } catch {
            XCTFail("should not throw an error: \(error.localizedDescription)")
        }
        XCTAssertEqual(retriableCommand.tryCount, 2)
    }
    
    func test_request_with_three_retries_two_retriable_error_then_success_case_should_get_success_result() async throws {
        let retriableHTTPError = NetworkingServerSideError.httpResponseError(statusCode: 123, data: nil)
        let requestableStub = RetryRequestableStub(retriedErrors: [retriableHTTPError, retriableHTTPError], endWithResult: 0)
        let retriableCommand = RetriableURLRequestCommand<Int>(retry: 3, requestable: AnyRequestable(requestableStub), retriableHTTPStatusCodes: [123])
        do {
            let result = try await retriableCommand.request()
            XCTAssertEqual(result, 0)
        } catch {
            XCTFail("should not throw an error: \(error.localizedDescription)")
        }
        XCTAssertEqual(retriableCommand.tryCount, 3)
    }
    
    func test_request_with_three_retries_one_nonretriable_error_then_success_case_should_get_error() async throws {
        let nonRetriableStatusCode = 404
        let nonRetriableHTTPError = NetworkingServerSideError.httpResponseError(statusCode: nonRetriableStatusCode, data: nil)
        let requestableStub = RetryRequestableStub(retriedErrors: [nonRetriableHTTPError], endWithResult: 0)
        let retriableCommand = RetriableURLRequestCommand<Int>(retry: 3, requestable: AnyRequestable(requestableStub))
        do {
            let _ = try await retriableCommand.request()
            XCTFail("should not get success result")
        } catch NetworkingServerSideError.httpResponseError(let statusCode, _){
            XCTAssertEqual(statusCode, nonRetriableStatusCode)
        } catch {
            XCTFail("should not catch other errors: \(error.localizedDescription)")
        }
        XCTAssertEqual(retriableCommand.tryCount, 1)
    }
    
    func test_request_with_three_retries_three_retriable_error_should_throw_noReceiveServerResponse_error() async throws {
        let retriableHTTPError = NetworkingServerSideError.httpResponseError(statusCode: 123, data: nil)
        let requestableStub = RetryRequestableStub<Int>(retriedErrors: [retriableHTTPError, retriableHTTPError, retriableHTTPError])
        let retriableCommand = RetriableURLRequestCommand<Int>(retry: 3, requestable: AnyRequestable(requestableStub), retriableHTTPStatusCodes: [123])
        do {
            let _ = try await retriableCommand.request()
            XCTFail("should not get success result")
        } catch NetworkingServerSideError.httpResponseError(_, _){
            XCTFail("should not catch http response errors")
        } catch let error {
            let error = error as? NetworkingServerSideError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .noServerResponse)
        }
        XCTAssertEqual(retriableCommand.tryCount, 3)
    }
}

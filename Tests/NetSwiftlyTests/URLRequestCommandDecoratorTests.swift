@testable import NetSwiftly
import XCTest

final class URLRequestCommandDecoratorTests: XCTestCase {

    func test_request_with_success_case_should_return_correct_value() async throws {
        let requestableStub = RequestableStub<Int>(delayInSeconds: 0.5, returning: 0)
        let decorator = RequestableDecorator(requestable: AnyRequestable(requestableStub))
        let result = try await decorator.request()
        XCTAssertEqual(result, 0)
    }
    
    func test_request_with_failure_case_should_throw_correct_error() async throws {
        let requestableStub = RequestableStub<Int>(delayInSeconds: 0.5, error: NetworkingClientSideError.cannotGenerateURL)
        let decorator = RequestableDecorator(requestable: AnyRequestable(requestableStub))
        do {
            let _ = try await decorator.request()
            XCTFail("should not get response")
        } catch let error as NetworkingClientSideError {
            XCTAssertEqual(error, NetworkingClientSideError.cannotGenerateURL)
        } catch {
            XCTFail("wrong error type")
        }
    }
}

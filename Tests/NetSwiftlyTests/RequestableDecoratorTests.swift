@testable import NetSwiftly
import XCTest

final class RequestableDecoratorTests: XCTestCase {

    func test_request_with_success_case_should_return_the_same_value_as_decorated_requestable() async throws {
        let expectedReturnValue = 0
        let decoratedRequestable = RequestableStub<Int>(returning: expectedReturnValue)
        let sut = RequestableDecorator<Int>(requestable: AnyRequestable(decoratedRequestable))
        let returnValue = try await sut.request()
        
        XCTAssertEqual(returnValue, expectedReturnValue)
    }
    
    func test_request_with_failure_case_should_return_the_same_error_as_decorated_requestable() async throws {
        let expectedReturnValue = 0
        let decoratedRequestable = RequestableStub<Int>(error: NetworkingClientSideError.cannotGenerateURL)
        let sut = RequestableDecorator<Int>(requestable: AnyRequestable(decoratedRequestable))
        
        do {
            let _ = try await decoratedRequestable.request()
            XCTFail("should not get response")
        } catch let error as NetworkingClientSideError {
            XCTAssertEqual(error, NetworkingClientSideError.cannotGenerateURL)
        } catch {
            XCTFail("wrong error type")
        }
    }
}

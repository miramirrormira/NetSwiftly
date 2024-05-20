@testable import NetSwiftly
import XCTest

final class RequestableDecoratorTests: XCTestCase {

    func test_request_should_return_the_same_value_as_decorated_requestable() async throws {
        let expectedReturnValue = 0
        let decoratedRequestable = RequestableStub<Int>(returning: expectedReturnValue)
        let sut = RequestableDecorator<Int>(requestable: AnyRequestable(decoratedRequestable))
        let returnValue = try await sut.request()
        
        XCTAssertEqual(returnValue, expectedReturnValue)
    }
}

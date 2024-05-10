@testable import NetSwiftly
import XCTest

final class URLRequestCommandDecoratorTests: XCTestCase {

    func test_request() async throws {
        let requestableStub = RequestableStub<Int>(delayInSeconds: 0.5, returning: 0)
        let decorator = RequestableDecorator(requestable: AnyRequestable(requestableStub))
        let result = try await decorator.request()
        XCTAssertEqual(result, 0)
    }
}

@testable import NetSwiftly
import XCTest

final class URLRequestCommandDecoratorTests: XCTestCase {

    func test_request() async throws {
        let requestableStub = RequestableStub<Int>(delayInSeconds: 0.5, result: 0)
        let decorator = URLRequestCommandDecorator(requestable: AnyRequestable(requestableStub))
        let result = try await decorator.request()
        XCTAssertEqual(result, 0)
    }
}

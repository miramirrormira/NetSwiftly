@testable import NetSwiftly
import XCTest

final class URLRequestDirectableDecoratorTests: XCTestCase {
    func test_getURLRequest_should_return_same_urlRequest_than_decorated_objects() async throws {
        let sut = URLRequestDirectableDecorator(urlRequestDirectable: EndpointURLRequestableFake())
        let urlRequest1 = try await sut.getURLRequest()
        let urlRequest2 = try await sut.urlRequestable.getURLRequest()
        XCTAssertEqual(urlRequest1, urlRequest2)
    }
}

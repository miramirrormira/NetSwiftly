@testable import NetSwiftly
import XCTest

final class URLRequestDirectableDecoratorTests: XCTestCase {

    func test_decorators_endpoint_and_decorated_objects_endpoint_are_identical() throws {
        let sut = URLRequestDirectableDecorator(urlRequestDirector: URLRequestDirectorFake())
        XCTAssertTrue(sut.endpoint === sut.urlRequestDirector.endpoint)
    }
    
    func test_decorators_networkConfiguration_and_decorated_objects_networkConfiguration_are_identical() throws {
        let sut = URLRequestDirectableDecorator(urlRequestDirector: URLRequestDirectorFake())
        XCTAssertTrue(sut.networkConfiguration === sut.urlRequestDirector.networkConfiguration)
    }
    
    func test_getURLRequest_should_return_same_urlRequest_than_decorated_objects() async throws {
        
        let sut = URLRequestDirectableDecorator(urlRequestDirector: URLRequestDirectorFake())
        let urlRequest1 = try await sut.getURLRequest()
        let urlRequest2 = try await sut.urlRequestDirector.getURLRequest()
        XCTAssertEqual(urlRequest1, urlRequest2)
    }
}

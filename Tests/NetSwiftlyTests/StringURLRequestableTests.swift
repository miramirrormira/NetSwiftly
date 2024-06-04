@testable import NetSwiftly
import XCTest

final class StringURLRequestableTests: XCTestCase {
    
    func test_init() throws {
        let sut = StringURLRequestDirector(urlString: "www.example.com")
        XCTAssertEqual(sut.urlString, "www.example.com")
    }
    
    func test_getRequest_with_invalid_urlString_should_throw_error() async throws {
        let sut = StringURLRequestDirector(urlString: "")
        do {
            let _ = try await sut.getURLRequest()
            XCTFail("should not succeed")
        } catch let error as NetworkingClientSideError {
            XCTAssertEqual(error, NetworkingClientSideError.cannotGenerateURL)
        } catch {
            XCTFail("wrong error")
        }
    }
    
    func test_getRequest_with_valid_urlString_should_return_correct_URLRequest() async throws {
        let sut = StringURLRequestDirector(urlString: "www.example.com")
        let request = try await sut.getURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "www.example.com")
    }
}

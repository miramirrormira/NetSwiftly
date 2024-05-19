@testable import NetSwiftly
import XCTest

final class URLRequestBuilderTests: XCTestCase {

    func test_initialization() throws {
        let url = try XCTUnwrap(URL(string: "www.example.com"))
        let urlRequest = URLRequest(url: url)
        let urlRequestBuilder = URLRequestBuilder(urlRequest: urlRequest)
        XCTAssertEqual(urlRequestBuilder.urlRequest, urlRequest)
    }
    
    func test_addHeaderFields_add_empty_headers_should_be_nil() {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        urlRequestBuilder.updateHeaderFields([:])
        XCTAssertNil(urlRequestBuilder.urlRequest.allHTTPHeaderFields)
    }
    
    func test_addHeaderFields_add_empty_headers_to_non_empty_should_not_change() {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        urlRequestBuilder.urlRequest.allHTTPHeaderFields = ["param1": "1"]
        urlRequestBuilder.updateHeaderFields([:])
        XCTAssertEqual(urlRequestBuilder.urlRequest.allHTTPHeaderFields, ["param1": "1"])
    }
    
    func test_addHeaderFields_with_new_header_should_contain_the_new_header() throws {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        urlRequestBuilder.updateHeaderFields(["param1": "1"])
        let allHTTPHeaderFields = try XCTUnwrap(urlRequestBuilder.urlRequest.allHTTPHeaderFields)
        
        XCTAssertEqual(allHTTPHeaderFields.count, 1)
        XCTAssertEqual(allHTTPHeaderFields["param1"], "1")
    }
    
    func test_addHeaderFields_add_header_with_existing_key_should_update_the_old_header() throws {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        urlRequestBuilder.urlRequest.allHTTPHeaderFields = ["param1": "1"]
        urlRequestBuilder.updateHeaderFields(["param1": "2"])
        let allHTTPHeaderFields = try XCTUnwrap(urlRequestBuilder.urlRequest.allHTTPHeaderFields)
        
        XCTAssertEqual(allHTTPHeaderFields.count, 1)
        XCTAssertEqual(allHTTPHeaderFields["param1"], "2")
    }
    
    func test_updateHTTPMethod() {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        XCTAssertNotEqual(urlRequestBuilder.urlRequest.httpMethod, "DELETE")
        urlRequestBuilder
            .updateHTTPMethod(.delete)
        XCTAssertEqual(urlRequestBuilder.urlRequest.httpMethod, "DELETE")
    }
    
    func test_updateHTTPBody_with_empty_body_should_return_nil() throws {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        let httpBodyParameters : [String : Any] = [:]
        try urlRequestBuilder.updateHTTPBody(httpBodyParameters, encoder: JSONBodyEncoder())
        XCTAssertEqual(urlRequestBuilder.urlRequest.httpBody, nil)
    }
    
    func test_updateHTTPBody_with_non_empty_body() throws {
        let urlRequestBuilder = URLRequestBuilder.fixture()
        let httpBodyParameters : [String : Any] = ["param1": 1, "param2": "2"]
        try urlRequestBuilder.updateHTTPBody(httpBodyParameters, encoder: JSONBodyEncoder())
        let encodeHTTPBody = try JSONBodyEncoder().encode(httpBodyParameters)
        XCTAssertEqual(urlRequestBuilder.urlRequest.httpBody, encodeHTTPBody)
    }
}

@testable import NetSwiftly
import XCTest

final class URLRequestDirectorTests: XCTestCase {

    func test_getURL() throws {
        let endpoint = Endpoint.fixture(path: "/test", queryParameters: ["param1" : "value1"])
        let networkConfig = NetworkConfiguration.fixture(host: "www.example.com", scheme: "https", apiBaseRoute: "/v1", queryParameters: ["param2" : "value2"])
        let director = URLRequestDirector(networkConfiguration: networkConfig, endpoint: endpoint)
        let url = try director.getURL()
        XCTAssertEqual(url.absoluteString, "https://www.example.com/v1/test?param2=value2&param1=value1")
    }
    
    func test_getURLRequest() throws {
        let bodyParams: [String: Any] = ["param1": "value1", "param2": 123]
        let endpoint = Endpoint.fixture(headerParameters: ["header1" : "header1Value"], bodyParameters: bodyParams)
        let networkConfig = NetworkConfiguration.fixture(headers: ["header2" : "header2Value"])
        let director = URLRequestDirector(networkConfiguration: networkConfig, endpoint: endpoint)
        let urlRequest = try director.getURLRequest()
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["header1"], "header1Value")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["header2"], "header2Value")
        XCTAssertEqual(urlRequest.httpBody, try JSONBodyEncoder().encode(bodyParams))
    }
}

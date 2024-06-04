@testable import NetSwiftly
import XCTest

final class URLRequestCommandTests: XCTestCase {
    
    func test_executeURLRequest_should_execute_urlSession_functions() async throws {
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(data: Data([1,2,3]))
        let urlRequestCommand = URLRequestCommand<[Int]>(urlRequestDirector: EndpointURLRequestableFake(),
                                                         urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        let (outputData, outputResponse) = try await urlRequestCommand.executeURLRequest()
        XCTAssertEqual(urlRequestResponse.data, outputData)
        XCTAssertEqual(urlRequestResponse.response, outputResponse)
    }
    
    func test_request_with_invalidServerResponse_should_throw_invalidServerResponse_error() async throws {
        
        let urlRequestResponse = try URLRequestResponse.fixtureForURLResponse()
        let urlRequestCommand = URLRequestCommand<[Int]>(urlRequestDirector: EndpointURLRequestableFake(),
                                                         urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        
        do {
            let _ = try await urlRequestCommand.request()
        } catch let error {
            guard case NetworkingServerSideError.invalidServerResponse = error else {
                return XCTFail()
            }
        }
    }
    
    func test_request_with_httpResponseError_should_throw_httpResponseError_error() async throws {
        
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(statusCode: 500)
        let urlRequestCommand = URLRequestCommand<[Int]>(urlRequestDirector: EndpointURLRequestableFake(),
                                                         urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        
        do {
            let _ = try await urlRequestCommand.request()
        } catch let error {
            guard case NetworkingServerSideError.httpResponseError(let statusCode, _) = error else {
                return XCTFail()
            }
            XCTAssertEqual(statusCode, 500)
        }
    }
    
    func test_request_with_success_case_should_return_decoded_data() async throws {
        let testStruct = TestStruct()
        let urlRequestResponse = try URLRequestResponse.fixtureForHTTPURLResponse(data: JSONEncoder().encode(testStruct))
        let urlRequestCommand = URLRequestCommand<TestStruct>(urlRequestDirector: EndpointURLRequestableFake(),
                                                              urlSession: URLSessionStub(data: urlRequestResponse.data, response: urlRequestResponse.response, delayInSeconds: 0.5))
        
        let decodedData = try await urlRequestCommand.request()
        XCTAssertEqual(decodedData, testStruct)
    }
}

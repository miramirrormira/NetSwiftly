//
//  File.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//
@testable import NetSwiftly
import Foundation

struct URLRequestResponse {
    let data: Data
    let response: URLResponse
}

extension URLRequestResponse {
    static func fixture(data: Data = Data([1,2,3]),
                        urlString: String = "www.example.com",
                        statusCode: Int = 200,
                        httpVersion: String? = nil,
                        headerFields: [String : String]? = nil) throws -> URLRequestResponse {
        let data = Data([1,2,3])
        guard let url = URL(string: urlString) else {
            throw NetworkingClientSideError.cannotGenerateURL
        }
        guard let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: httpVersion, headerFields: headerFields) else {
            throw URLRequestTestErrors.cannnotGenerateHTTPURLResponse
        }
        return URLRequestResponse(data: data, response: response)
    }
}

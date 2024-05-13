//
//  URLRequestResponse.swift
//
//
//  Created by Mira Yang on 4/29/24.
//
import Foundation

struct URLRequestResponse {
    let data: Data
    let response: URLResponse
}

extension URLRequestResponse {
    static func fixtureForHTTPURLResponse(data: Data = Data([1,2,3]),
                                          urlString: String = "www.example.com",
                                          statusCode: Int = 200,
                                          httpVersion: String? = nil,
                                          headerFields: [String : String]? = nil) throws -> URLRequestResponse {
        let data = data
        guard let url = URL(string: urlString) else {
            throw NetworkingClientSideError.cannotGenerateURL
        }
        guard let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: httpVersion, headerFields: headerFields) else {
            throw URLRequestTestErrors.cannnotGenerateHTTPURLResponse
        }
        return URLRequestResponse(data: data, response: response)
    }
    
    static func fixtureForURLResponse(data: Data = Data([1,2,3]),
                                      urlString: String = "www.example.com",
                                      mimeType: String? = nil,
                                      expectedContentLength: Int = 0,
                                      textEncodingName: String? = nil) throws -> URLRequestResponse {
        let data = data
        guard let url = URL(string: urlString) else {
            throw NetworkingClientSideError.cannotGenerateURL
        }
        let response = URLResponse(url: url, mimeType: mimeType, expectedContentLength: expectedContentLength, textEncodingName: textEncodingName)
        return URLRequestResponse(data: data, response: response)
    }
}

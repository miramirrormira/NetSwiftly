//
//  URLRequestBuilderFixture.swift
//  
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation

public extension URLRequestBuilder {
    static func fixture(urlString: String = "www.example.com") -> URLRequestBuilder {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        return URLRequestBuilder(urlRequest: urlRequest)
    }
}

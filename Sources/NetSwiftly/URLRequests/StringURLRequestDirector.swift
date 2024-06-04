//
//  StringURLRequestable.swift
//  
//
//  Created by Mira Yang on 6/4/24.
//

import Foundation
public class StringURLRequestDirector: URLRequestDirectable {
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    public func getURLRequest() async throws -> URLRequest {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        throw NetworkingClientSideError.cannotGenerateURL
    }
}

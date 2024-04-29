//
//  URLRequestDirectorDummy.swift
//  
//
//  Created by Mira Yang on 4/27/24.
//

@testable import NetSwiftly
import Foundation

struct URLRequestDirectorDummy: URLRequestDirectable {
    
    var endpoint: Endpoint
    var networkConfiguration: NetworkConfiguration
    
    init() {
        self.endpoint = Endpoint.fixture()
        self.networkConfiguration = NetworkConfiguration.fixture()
    }
    
    func getURL() throws -> URL {
        URL(string: "www.example.com")!
    }
    
    func getURLRequest() throws -> URLRequest {
        URLRequest(url: try getURL())
    }
    
}

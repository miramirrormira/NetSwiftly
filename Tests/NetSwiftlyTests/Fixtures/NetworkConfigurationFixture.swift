//
//  NetworkConfigurationFixture.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation
@testable import NetSwiftly

extension NetworkConfiguration {
    static func fixture(host: String = "www.example.com",
                        scheme: String = "https",
                        apiBaseRoute: String? = "v1",
                        headers: [String : String] = ["networkConfigHeaderParam": "networkConfigHeaderParamValue"],
                        queryParameters: [String : String] = ["networkConfigQueryParam": "networkConfigQueryParamValue"]) -> NetworkConfiguration {
        return NetworkConfiguration(host: host,
                                    scheme: scheme,
                                    apiBaseRoute: apiBaseRoute,
                                    headers: headers,
                                    queryParameters: queryParameters)
    }
}

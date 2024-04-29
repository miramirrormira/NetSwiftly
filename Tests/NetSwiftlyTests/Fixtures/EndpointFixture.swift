//
//  EndpointFixture.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation
@testable import NetSwiftly

extension Endpoint {
    static func fixture(path: String = "/test",
                        method: HTTPMethod = .get,
                        headerParameters: [String : String] = ["endpointHeaderParam": "endpointHeaderParamValue"],
                        queryParameters: [String : Any] = ["endpointQueryParam": "endpointQueryParamValue"],
                        bodyParameters: [String : Any] = ["endpointBodyParam": "endpointBodyParam1Value"],
                        bodyEncoder: BodyEncoder = JSONBodyEncoder()) -> Endpoint {
        return Endpoint(path: path,
                        method: method,
                        headerParameters: headerParameters,
                        queryParameters: queryParameters,
                        bodyParameters: bodyParameters,
                        bodyEncoder: bodyEncoder)
    }
}

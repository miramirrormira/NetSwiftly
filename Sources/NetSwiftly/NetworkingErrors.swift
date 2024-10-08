//
//  NetworkingErrors.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

public enum NetworkingClientSideError: Error {
    case cannotGenerateURLComponents
    case cannotGenerateURL
    case wrongURLRequestableType
    case noResponseValue
}

public enum NetworkingServerSideError: Error {
    case invalidServerResponse
    case noServerResponse
    case httpResponseError(statusCode: Int, data: Data?)
    
    public var statusCode: Int? {
        switch self {
        case .httpResponseError(let statusCode, _):
            return statusCode
        default:
            return nil
        }
    }
}

extension NetworkingServerSideError: Equatable { }

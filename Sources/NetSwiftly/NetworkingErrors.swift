//
//  NetworkingErrors.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

enum NetworkingClientSideError: Error {
    case cannotGenerateURLComponents
    case cannotGenerateURL
}

enum NetworkingServerSideError: Error {
    case invalidServerResponse
    case noServerResponse
    case httpResponseError(statusCode: Int, data: Data?)
    
    var statusCode: Int? {
        switch self {
        case .httpResponseError(let statusCode, _):
            return statusCode
        default:
            return nil
        }
    }
}

extension NetworkingServerSideError: Equatable {
    
}

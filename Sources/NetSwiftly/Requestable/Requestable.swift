//
//  RequestCommand.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation
public protocol Requestable {
    associatedtype Response
    func request() async throws -> Response
}

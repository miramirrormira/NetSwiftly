//
//  File.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

protocol PaginationQueryStrategy {
    func getNextPageQueryParameters() -> [String: Int]
}

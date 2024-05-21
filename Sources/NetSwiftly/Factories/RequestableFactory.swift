//
//  File.swift
//  
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation

protocol RequestableFactory {
    associatedtype RequestableProduct: Requestable
    func makeRequestable() -> RequestableProduct
}

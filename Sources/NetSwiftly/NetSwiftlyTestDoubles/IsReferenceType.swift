//
//  File.swift
//  
//
//  Created by Mira Yang on 5/19/24.
//

import Foundation
func isReferenceType(_ object: Any) -> Bool {
    return (object as AnyObject) !== (object as AnyObject)
}

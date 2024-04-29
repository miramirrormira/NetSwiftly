//
//  OffsetBasedQueryStrategyFixture.swift
//
//
//  Created by Mira Yang on 4/29/24.
//

import Foundation
@testable import NetSwiftly

extension OffsetBasedQueryStrategy {
    static func fixture(offsetKey: String = "offset",
                        currentOffset: Int = 0,
                        limitKey: String = "limit",
                        limit: Int = 10) -> OffsetBasedQueryStrategy {
        OffsetBasedQueryStrategy(offsetKey: offsetKey, currentOffset: currentOffset, limitKey: limitKey, limit: limit)
    }
}

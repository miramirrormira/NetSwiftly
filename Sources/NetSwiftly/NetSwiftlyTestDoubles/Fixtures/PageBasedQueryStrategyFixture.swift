//
//  PageBasedQueryStrategyFixture.swift
//
//
//  Created by Mira Yang on 4/26/24.
//

import Foundation

extension PageBasedQueryStrategy {
    static func fixture(pageKey: String = "page",
                        currentPage: Int = 0,
                        pageSizeInfo: (String, Int)? = nil) -> PageBasedQueryStrategy {
        PageBasedQueryStrategy(pageKey: pageKey, currentPage: currentPage, pageSizeInfo: pageSizeInfo)
    }
}

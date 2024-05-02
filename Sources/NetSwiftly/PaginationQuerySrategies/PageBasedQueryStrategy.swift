//
//  PageBasedQueryStrategy.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

public class PageBasedQueryStrategy: PaginationQueryStrategy {
    
    public let pageKey: String
    public var currentPage: Int
    public var pageSizeInfo: (String, Int)?
    
    public init(pageKey: String, 
         currentPage: Int = 0,
         pageSizeInfo: (String, Int)? = nil) {
        self.pageKey = pageKey
        self.currentPage = currentPage
        self.pageSizeInfo = pageSizeInfo
    }
    
    private func updateCurrentPage() {
        currentPage += 1
    }
    
    public func getNextPageQueryParameters() -> [String : Int] {
        updateCurrentPage()
        var result = [String: Int]()
        result[pageKey] = currentPage
        if let pageSizeInfo = pageSizeInfo {
            result[pageSizeInfo.0] = pageSizeInfo.1
        }
        return result
    }
}

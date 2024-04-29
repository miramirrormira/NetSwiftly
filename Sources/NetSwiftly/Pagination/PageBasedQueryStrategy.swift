//
//  File.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

class PageBasedQueryStrategy: PaginationQueryStrategy {
    
    let pageKey: String
    var currentPage: Int
    var pageSizeInfo: (String, Int)?
    
    init(pageKey: String, 
         currentPage: Int = 0,
         pageSizeInfo: (String, Int)? = nil) {
        self.pageKey = pageKey
        self.currentPage = currentPage
        self.pageSizeInfo = pageSizeInfo
    }
    
    private func updateCurrentPage() {
        currentPage += 1
    }
    
    func getNextPageQueryParameters() -> [String : Int] {
        updateCurrentPage()
        var result = [String: Int]()
        result[pageKey] = currentPage
        if let pageSizeInfo = pageSizeInfo {
            result[pageSizeInfo.0] = pageSizeInfo.1
        }
        return result
    }
}

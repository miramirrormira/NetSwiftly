//
//  PageBasedQueryStrategy.swift
//  
//
//  Created by Mira Yang on 4/28/24.
//

import Foundation

public class PageBasedQueryStrategy: PaginationQueryStrategy {
    
    private let pageKey: String
    public var currentPage: Int
    public var pageSizeInfo: (String, Int)?
    private let threadSafetyQueue: DispatchQueue
    
    public init(pageKey: String,
                currentPage: Int = 0,
                pageSizeInfo: (String, Int)? = nil,
                threadSafetyQueue: DispatchQueue = .global(qos: .background)) {
        self.pageKey = pageKey
        self.currentPage = currentPage
        self.pageSizeInfo = pageSizeInfo
        self.threadSafetyQueue = threadSafetyQueue
    }
    
    private func updateCurrentPage() async throws -> Int {
        await withCheckedContinuation { continuation in
            threadSafetyQueue.async(flags: .barrier) {
                self.currentPage += 1
                continuation.resume(returning: self.currentPage)
            }
        }
    }
    
    public func getNextPageQueryParameters() async throws -> [String : Int] {
        let currentPage = try await updateCurrentPage()
        var result = [String: Int]()
        result[pageKey] = currentPage
        if let pageSizeInfo = pageSizeInfo {
            result[pageSizeInfo.0] = pageSizeInfo.1
        }
        return result
    }
}

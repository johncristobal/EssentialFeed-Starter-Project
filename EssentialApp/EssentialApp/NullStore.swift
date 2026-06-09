//
//  NullStore.swift
//  EssentialApp
//
//  Created by JOHN CRIS on 01/06/26.
//

import Foundation
import EssentialFeed

class NullStore: FeedStore & FeedImageDataStore {
    func deleteCachedFeed() throws {
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedFeed? { .none }
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) throws -> Data? { .none }
}

//
//  InMemoryFeedStore.swift
//  EssentialApp
//
//  Created by JOHN CRIS on 11/04/26.
//

//import Foundation
//
//@MainActor
//class InMemoryFeedStore {
//    private(set) var feedCache: CachedFeed?
//    private var feedImageDataCache: [URL: Data] = [:]
//    
//    private init(feedCache: CachedFeed? = nil) {
//        self.feedCache = feedCache
//    }
//}
//
//extension InMemoryFeedStore: FeedStore {
//    func deleteCachedFeed() throws {
//        feedCache = nil
//    }
//    
//    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
//        feedCache = CachedFeed(feed: feed, timestamp: timestamp)
//    }
//    
//    func retrieve() throws -> CachedFeed? {
//        feedCache
//    }
//}
//
//extension InMemoryFeedStore: FeedImageDataStore {
//    func insert(_ data: Data, for url: URL) throws {
//        feedImageDataCache[url] = data
//    }
//    
//    func retrieve(dataForURL url: URL) throws -> Data? {
//        feedImageDataCache[url]
//    }
//}
//
//extension InMemoryFeedStore {
//    static var empty: InMemoryFeedStore {
//        InMemoryFeedStore()
//    }
//    
//    static var withExpiredFeedCache: InMemoryFeedStore {
//        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date.distantPast))
//    }
//    
//    static var withNonExpiredFeedCache: InMemoryFeedStore {
//        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date()))
//    }
//}

import Foundation

@MainActor
public class InMemoryFeedStore {
    private var feedCache: CachedFeed?
    private var feedImageDataCache = NSCache<NSURL, NSData>()
    
    public init() {}
}

extension InMemoryFeedStore: FeedStore {
    public func deleteCachedFeed() throws {
        feedCache = nil
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        feedCache = CachedFeed(feed: feed, timestamp: timestamp)
    }

    public func retrieve() throws -> CachedFeed? {
        feedCache
    }
}

extension InMemoryFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL) throws {
        feedImageDataCache.setObject(data as NSData, forKey: url as NSURL)
    }
    
    public func retrieve(dataForURL url: URL) throws -> Data? {
        feedImageDataCache.object(forKey: url as NSURL) as Data?
    }
}

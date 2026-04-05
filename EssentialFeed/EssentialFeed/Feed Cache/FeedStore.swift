//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 25/02/26.
//
import Foundation

//public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

//public enum RetrieveCachedFeedResult {
//    case empty
//    case found(feed: [LocalFeedImage], timestamp: Date)
//    case failure(Error)
//}

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}

//public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)
//
//public protocol FeedStore {
//    func deleteCachedFeed() throws
//    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
//    func retrieve() throws -> CachedFeed?
//}

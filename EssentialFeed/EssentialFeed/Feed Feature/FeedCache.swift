//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 08/04/26.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}

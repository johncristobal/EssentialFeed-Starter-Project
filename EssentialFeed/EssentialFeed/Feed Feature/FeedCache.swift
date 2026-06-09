//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 08/04/26.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}

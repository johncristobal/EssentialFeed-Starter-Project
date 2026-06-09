//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 08/04/26.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}

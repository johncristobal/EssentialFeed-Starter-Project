//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 03/04/26.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}

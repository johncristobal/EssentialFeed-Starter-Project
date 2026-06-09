//
//  FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 19/03/26.
//
import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}

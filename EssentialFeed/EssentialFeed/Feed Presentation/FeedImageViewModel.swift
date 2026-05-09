//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 20/03/26.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}

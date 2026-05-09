//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 20/03/26.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}

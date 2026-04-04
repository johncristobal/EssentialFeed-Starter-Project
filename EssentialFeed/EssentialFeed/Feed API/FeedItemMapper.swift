//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 13/02/26.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {

        let items: [RemoteFeedItem]
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK,
            let root = try? JSONDecoder().decode(Root.self, from: data) else {
            //return .failure(.invalidData)
            //return .failure(RemoteFeedLoader.Error.invalidData)
            throw RemoteFeedLoader.Error.invalidData
        }

//        return .success(root.feed)
        return root.items
    }
}

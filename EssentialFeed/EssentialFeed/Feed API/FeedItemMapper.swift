//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 13/02/26.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
//        let items: [Item]
//
//        var feed: [FeedItem] {
//            return items.map { $0.item }
//        }
        let items: [RemoteFeedItem]
    }
//
//    private struct Item: Decodable {
//        let id: UUID
//        let description: String?
//        let location: String?
//        let image: URL
//
//        var item: FeedItem {
//            return FeedItem(id: id, description: description, location: location, imageURL: image)
//        }
//    }

    private static var OK_200: Int { return 200 }

    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data) else {
            //return .failure(.invalidData)
            //return .failure(RemoteFeedLoader.Error.invalidData)
            throw RemoteFeedLoader.Error.invalidData
        }

//        return .success(root.feed)
        return root.items
    }
}

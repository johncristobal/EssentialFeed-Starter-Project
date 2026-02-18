//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 11/02/26.
//
import Foundation

//Init
//class HTTPClient {
//    static let shared = HTTPClient()
//    var requestedUrl: URL?
//    private init() {}
//}



public final class RemoteFeedLoader: FeedLoader {
//    Init
//    func load() {
//        HTTPClient.shared.requestedUrl = URL(string: "https://test.com")!
//    }
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
//    public enum Result: Equatable {
//        case success([FeedItem])
//        case failure(Error)
//    }
    public typealias Result = LoadFeedResult
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }

    public func load(completion: @escaping(Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
//                do {
//                    let items = try FeedItemsMapper.map(data, response)
//                    completion(.success(items))
//                } catch {
//                    completion(.failure(.invalidData))
//                }
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
//                completion(.failure(.connectivity))
                completion(.failure(Error.connectivity))
            }
        }
    }
}


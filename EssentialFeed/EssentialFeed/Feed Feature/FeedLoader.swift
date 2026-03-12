//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

// cambio 1
//public enum LoadFeedResult {
//	case success([FeedImage])
//	case failure(Error)
//}

// cambio 2
//public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    // cambio 3
    typealias Result = Swift.Result<[FeedImage], Error>
	func load(completion: @escaping (Result) -> Void)
}

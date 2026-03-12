//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 13/02/26.
//

import Foundation

// Mismo cambio con Swift.Result
//public enum HTTPClientResult {
//    case success(Data, HTTPURLResponse)
//    case failure(Error)
//}

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 13/02/26.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    @discardableResult
    func get(from url: URL, completion: @Sendable @escaping (Result) -> Void) -> HTTPClientTask
}

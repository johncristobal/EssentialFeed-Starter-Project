//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 13/02/26.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}

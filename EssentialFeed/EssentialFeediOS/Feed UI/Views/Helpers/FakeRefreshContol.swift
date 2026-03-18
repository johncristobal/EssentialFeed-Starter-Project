//
//  FakeRefreshContol.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 18/03/26.
//

import UIKit

public class FakeRefreshContol: UIRefreshControl {
    private var _isRefreshing: Bool = false
    
    public override func beginRefreshing() { _isRefreshing = true }
    public override func endRefreshing() { _isRefreshing = false }
    public override var isRefreshing: Bool { _isRefreshing }
}

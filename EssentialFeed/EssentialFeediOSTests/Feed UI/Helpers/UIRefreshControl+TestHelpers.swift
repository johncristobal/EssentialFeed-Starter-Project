//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 19/03/26.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}

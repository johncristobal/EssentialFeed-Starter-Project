//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 18/03/26.
//

import UIKit
import EssentialFeed

public class FeedRefreshViewController: NSObject {
//    lazy var view: UIRefreshControl = {
//        let view = UIRefreshControl()
//        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return view
//    }()
    private(set) lazy var view = binded(UIRefreshControl())
    
//    private let feedLoader: FeedLoader
    private let viewModel: FeedViewModel
    
//    init(feedLoader: FeedLoader) {
//        self.feedLoader = feedLoader
//    }
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
//    var onRefresh: (([FeedImage]) -> Void)?
    
    @objc func refresh() {
//        view.beginRefreshing()
//        feedLoader.load { [weak self] result in
//            if let feed = try? result.get() {
//                self?.onRefresh?(feed)
//            }
//            self?.view.endRefreshing()
//        }
        viewModel.loadFeed()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}

public extension FeedRefreshViewController {
    func replaceRefreshControlWithFakeForiOS17Support() {
        let fake = FakeRefreshContol()

        view.allTargets.forEach { target in
            view.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                fake.addTarget(target, action: Selector(action), for: .valueChanged)
            }
        }

        view = fake
    }
}

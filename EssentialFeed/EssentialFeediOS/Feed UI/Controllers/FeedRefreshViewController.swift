//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 18/03/26.
//

import UIKit
import EssentialFeed

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

public class FeedRefreshViewController: NSObject, FeedLoadingView {

    private(set) lazy var view = loadView()
    private let delegate: FeedRefreshViewControllerDelegate
    
    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
    }
//    private(set) lazy var view = binded(UIRefreshControl())
//    private let viewModel: FeedViewModel
    
//    init(viewModel: FeedViewModel) {
//        self.viewModel = viewModel
//    }
    
    @objc func refresh() {
//        viewModel.loadFeed()
        delegate.didRequestFeedRefresh()
    }
    
//    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
//        viewModel.onLoadingStateChange = { [weak self] isLoading in
//            if isLoading {
//                self?.view.beginRefreshing()
//            } else {
//                self?.view.endRefreshing()
//            }
//        }
//        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return view
//    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
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

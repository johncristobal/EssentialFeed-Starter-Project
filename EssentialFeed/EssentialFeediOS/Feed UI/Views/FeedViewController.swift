//
//  FeedViewController.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 14/03/26.
//

import UIKit
import EssentialFeed

public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {

    public var refreshController: FeedRefreshViewController?
    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }

//    private var feedLoader: FeedLoader?
//    private var imageLoader: FeedImageDataLoader?
//    private var tableModel = [FeedImage]()
//    private var tasks = [IndexPath: FeedImageDataLoaderTask]()
    private var onViewIsAppearing: ((FeedViewController) -> Void)?
    
    convenience init(refreshController: FeedRefreshViewController) {
        self.init()
        self.refreshController = refreshController
//        self.feedLoader = feedLoader
//        self.imageLoader = imageLoader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        tableView.prefetchDataSource = self
        
        onViewIsAppearing = { vc in
            vc.refreshControl = vc.refreshController?.view
            vc.refreshController?.refresh()
            vc.onViewIsAppearing = nil
        }
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        onViewIsAppearing?(self)
    }
    
//    @objc private func load() {
//        refreshControl?.beginRefreshing()
//        feedLoader?.load { [weak self] result in
//            if let feed = try? result.get() {
//                self?.tableModel = feed
//                self?.tableView.reloadData()
//            }
//            self?.refreshControl?.endRefreshing()
//        }
//    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).cancelLoad()
    }
}

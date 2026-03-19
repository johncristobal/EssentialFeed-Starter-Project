//
//  FeedImageCellController.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 18/03/26.
//

import UIKit

final class FeedImageCellController {
//    private var task: FeedImageDataLoaderTask?
//    private let model: FeedImage
//    private let imageLoader: FeedImageDataLoader
    private let viewModel: FeedImageViewModel<UIImage>
    
//    init(model: FeedImage, imageLoader: FeedImageDataLoader) {
//        self.model = model
//        self.imageLoader = imageLoader
//    }
    
    init(viewModel: FeedImageViewModel<UIImage>) {
        self.viewModel = viewModel
    }
    
    func view() -> UITableViewCell {
        let cell = binded(FeedImageCell())
        viewModel.loadImageData()
        return cell
    }
    
    func preload() {
//        task = imageLoader.loadImageData(from: model.url) { _ in }
        viewModel.loadImageData()
    }
    
    func cancelLoad() {
//        task?.cancel()
        viewModel.cancelImageDataLoad()
    }
    
    private func binded(_ cell: FeedImageCell) -> FeedImageCell {
        cell.locationContainer.isHidden = !viewModel.hasLocation
        cell.locationLabel.text = viewModel.location
        cell.descriptionLabel.text = viewModel.description
        cell.onRetry = viewModel.loadImageData
        
        viewModel.onImageLoad = { [weak cell] image in
            cell?.feedImageView.image = image
        }
        
        viewModel.onImageLoadingStateChange = { [weak cell] isLoading in
            cell?.feedImageContainer.isShimmering = isLoading
        }
        
        viewModel.onShouldRetryImageLoadStateChange = { [weak cell] shouldRetry in
            cell?.feedImageRetryButton.isHidden = !shouldRetry
        }
        
        return cell
    }
}

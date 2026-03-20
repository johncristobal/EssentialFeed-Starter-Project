//
//  FeedImageCellController.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 18/03/26.
//

import UIKit

protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

final class FeedImageCellController: FeedImageView {
//    private let viewModel: FeedImageViewModel<UIImage>
    
    private let delegate: FeedImageCellControllerDelegate
    private lazy var cell = FeedImageCell()
    
//    init(viewModel: FeedImageViewModel<UIImage>) {
//        self.viewModel = viewModel
//    }
    
    init(delegate: FeedImageCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view() -> UITableViewCell {
//        let cell = binded(FeedImageCell())
//        viewModel.loadImageData()
        delegate.didRequestImage()
        return cell
    }
    
    func preload() {
//        viewModel.loadImageData()
        delegate.didRequestImage()
    }
    
    func cancelLoad() {
//        viewModel.cancelImageDataLoad()
        delegate.didCancelImageRequest()
    }
    
    func display(_ viewModel: FeedImageViewModel<UIImage>) {
        cell.locationContainer.isHidden = !viewModel.hasLocation
        cell.locationLabel.text = viewModel.location
        cell.descriptionLabel.text = viewModel.description

        cell.feedImageView.image = viewModel.image
        cell.feedImageContainer.isShimmering = viewModel.isLoading
        cell.feedImageRetryButton.isHidden = !viewModel.shouldRetry
        cell.onRetry = delegate.didRequestImage
    }
    
//    private func binded(_ cell: FeedImageCell) -> FeedImageCell {
//        cell.locationContainer.isHidden = !viewModel.hasLocation
//        cell.locationLabel.text = viewModel.location
//        cell.descriptionLabel.text = viewModel.description
//        cell.onRetry = viewModel.loadImageData
//        
//        viewModel.onImageLoad = { [weak cell] image in
//            cell?.feedImageView.image = image
//        }
//        
//        viewModel.onImageLoadingStateChange = { [weak cell] isLoading in
//            cell?.feedImageContainer.isShimmering = isLoading
//        }
//        
//        viewModel.onShouldRetryImageLoadStateChange = { [weak cell] shouldRetry in
//            cell?.feedImageRetryButton.isHidden = !shouldRetry
//        }
//        
//        return cell
//    }
}

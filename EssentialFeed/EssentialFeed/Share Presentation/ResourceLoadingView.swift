//
//  ResourceLoadingView.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 09/05/26.
//

import Foundation

@MainActor
public protocol ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel)
}

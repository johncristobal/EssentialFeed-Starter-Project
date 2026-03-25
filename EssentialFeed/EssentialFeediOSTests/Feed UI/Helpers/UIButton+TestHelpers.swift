//
//  UIButton+TestHelpers.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 19/03/26.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}

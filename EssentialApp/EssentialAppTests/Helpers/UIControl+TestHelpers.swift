//
//  UIControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 19/03/26.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}

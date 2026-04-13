//
//  UIView+TestHelpers.swift
//  EssentialApp
//
//  Created by JOHN CRIS on 13/04/26.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}

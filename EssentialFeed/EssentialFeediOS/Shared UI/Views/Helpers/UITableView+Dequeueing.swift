//
//  UITableView+Dequeueing.swift
//  EssentialFeed
//
//  Created by JOHN CRIS on 23/03/26.
//
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}

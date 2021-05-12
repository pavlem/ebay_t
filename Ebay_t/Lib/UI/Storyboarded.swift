//
//  Storyboarded.swift
//  Ebay_t
//
//   Created by Pavle Mijatovic on 12.5.21..
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

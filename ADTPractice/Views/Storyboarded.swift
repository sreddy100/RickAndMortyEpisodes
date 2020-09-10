//
//  Storyboarded.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation
import UIKit
//MARK:- Storyboarded: for Coordinated Design Pattern
protocol Storyboarded {
    static func instantiate()->Self
}


extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: Constants.vc.main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

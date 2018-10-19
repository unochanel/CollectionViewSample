//
//  UIView;Ex.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

extension UIView {
    func parentAlertController() -> UIAlertController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIAlertController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}


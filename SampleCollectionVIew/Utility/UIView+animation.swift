//
//  UIView+animation.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/22.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn(type: Double, completed: (() -> ())? = nil) {
        fadeIn(duration: type, completed: completed)
    }
    
    func fadeIn(duration: Double, completed: (() -> ())? = nil) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            self.center.y -= 300
            self.alpha = 1
        }) { finished in
            completed?()
        }
    }
    
    func fadeOut(type: Double, completed: (() -> ())? = nil) {
        fadeOut(duration: type, completed: completed)
    }
    
    func fadeOut(duration: Double, completed: (() -> ())? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
            self.center.y += 300
        }) { finished in
            completed?()
        }
    }
}

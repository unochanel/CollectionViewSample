//
//  Functions.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/22.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

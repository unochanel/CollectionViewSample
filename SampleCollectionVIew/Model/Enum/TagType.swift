//
//  TagType.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation
import UIKit

enum CellType: String {
    case positive
    case normal
    case negative
    
    func labelColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.cyan.cgColor
        case .negative:
            return UIColor.orange.cgColor
        default:
            return UIColor.gray.cgColor
        }
    }
    
    func borderColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.blue.cgColor
        case .negative:
            return UIColor.red.cgColor
        default:
            return UIColor.black.cgColor
        }
    }
    
    func tappedLabelColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.blue.cgColor
        case .negative:
            return UIColor.red.cgColor
        default:
            return UIColor.black.cgColor
        }
    }
}

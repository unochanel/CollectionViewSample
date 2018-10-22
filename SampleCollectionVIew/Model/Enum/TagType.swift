//
//  TagType.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation
import UIKit

enum CellType: Int {
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
    
    func toString() -> String {
        switch self {
        case .positive: return "ポジティブ"
        case .normal: return "ノーマル"
        case .negative: return "ネガティブ"
        }
    }
    
    func explain() -> String {
        switch self {
        case .positive: return "カラダやココロにとって良いこと"
        case .normal: return "どちらでもない"
        case .negative: return "カラダやココロにとって悪いこと"
        }
    }

    func setImage() -> UIImage {
        switch self {
        case .positive:
            return R.image.positive()!
        case .normal:
            return R.image.normal()!
        case .negative:
            return R.image.negative()!
        }
    }

    func toEnglish() -> String {
        switch self {
        case .positive: return "positive"
        case .normal: return "normal"
        case .negative: return "negative"
        }
    }
}

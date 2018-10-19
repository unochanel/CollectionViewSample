//
//  Cell.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

enum CellType: String {
    case positive
    case negative

    func labelColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.cyan.cgColor
        case .negative:
            return UIColor.orange.cgColor
        }
    }

    func borderColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.blue.cgColor
        case .negative:
            return UIColor.red.cgColor
        }
    }
    
    func tappedLabelColor() -> CGColor {
        switch self {
        case .positive:
            return UIColor.blue.cgColor
        case .negative:
            return UIColor.red.cgColor
        }
    }
}

final class Cell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    @IBOutlet weak var label: UILabel!

    func configureCell(item: TagResponse.Tag) {
        label.text = item.tag
        guard let cellType = CellType(rawValue: item.type) else { return }
        configureLabelLayer(cellType: cellType)
    }

    func configureLabelLayer(cellType: CellType) {
        label.layer.borderColor = cellType.borderColor()
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 7
        label.layer.backgroundColor = cellType.labelColor()
    }

    func tappedTag(cellType: CellType) {
        label.layer.borderWidth = 0
        label.layer.cornerRadius = 7
        label.layer.backgroundColor = cellType.tappedLabelColor()
    }
}

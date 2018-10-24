//
//  Cell.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class Cell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    @IBOutlet weak var label: UILabel!

    func configureCell(creatingTag: TagList) {
        label.text = creatingTag.tag
        let cellType = CellType.switchCellType(cellType: creatingTag.type)
        if creatingTag.tapped == true {
            tappedTag(cellType: cellType)
        } else {
            configureLabelLayer(cellType: cellType)
        }
    }

    private func configureLabelLayer(cellType: CellType) {
        label.layer.borderColor = cellType.borderColor()
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.layer.backgroundColor = cellType.labelColor()
        label.textColor = cellType.textColor()
    }

    private func tappedTag(cellType: CellType) {
        label.textColor = UIColor.white
        label.layer.borderWidth = 0
        label.layer.cornerRadius = 7
        label.layer.backgroundColor = cellType.tappedLabelColor()
    }
}

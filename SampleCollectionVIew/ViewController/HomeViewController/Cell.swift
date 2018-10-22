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

    func configureCell(cellType: CellType, text: String) {
        label.text = text
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

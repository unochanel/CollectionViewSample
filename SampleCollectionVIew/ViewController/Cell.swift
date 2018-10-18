//
//  Cell.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

enum CellType: Int {
    case positive
    case negative
}

class Cell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    @IBOutlet private weak var label: UILabel!

    func configureCell(item: String) {
        label.text = item
        configureLabelLayer()
    }

    private func configureLabelLayer() {
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 7
        label.layer.backgroundColor = UIColor.cyan.cgColor
    }
}

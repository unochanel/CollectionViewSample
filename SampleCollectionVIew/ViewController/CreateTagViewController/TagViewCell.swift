//
//  TagViewCell.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class TagViewCell: UITableViewCell {
    static let reuseIdentifier = "TagViewCell"

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet private weak var faceImage: UIImageView!
    @IBOutlet private weak var tagTypeLabel: UILabel!
    @IBOutlet private weak var explainTagTypeLabel: UILabel!
    @IBOutlet weak var separeteinsent: UIView!
    
    func configureCell(cellType: CellType) {
        selectionStyle = .none
        faceImage.image = cellType.setImage()
        tagTypeLabel.text = cellType.toString()
        explainTagTypeLabel.text = cellType.explain()
        switch cellType {
        case .normal, .negative:
            separeteinsent.isHidden = true
        default: return
        }
    }
}

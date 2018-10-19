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

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet private weak var faceImage: UIImageView!
    @IBOutlet private weak var tagTypeLabel: UILabel!
    @IBOutlet private weak var explainTagTypeLabel: UILabel!
    @IBOutlet private weak var separeteinsent: UIView!
    
    func configureCell(cellType: CellType) {
        switch cellType {
        case .positive:
            faceImage.image = R.image.positive()!
            tagTypeLabel.text = "ポジティブ"
            explainTagTypeLabel.text = "カラダやココロにとって良いこと"
        case .normal:
            separeteinsent.isHidden = true
            faceImage.image = R.image.normal()!
            tagTypeLabel.text = "ノーマル"
            explainTagTypeLabel.text = "どちらでもない"
        case .negative:
            separeteinsent.isHidden = true
            faceImage.image = R.image.negative()!
            tagTypeLabel.text = "ネガティブ"
            explainTagTypeLabel.text = "カラダやココロにとって悪いこと"
        }
    }
}

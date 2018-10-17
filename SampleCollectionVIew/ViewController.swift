//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tagList = ["眠い", "食事", "残業", "仕事", "睡眠", "勉強","７文字のタグだ", "８文字のタグです"]

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension ViewController {
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCell()
    }
    private func configureCell() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.configureCell(item: tagList[indexPath.row])
        return cell
    }
}

extension ViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tagList[indexPath.row]
        label.sizeToFit()
        let labelSize = CGSize(width: label.frame.size.width, height: label.frame.size.height)
        return labelSize
    }

}

extension ViewController {
    class CollectionViewCell: UICollectionViewCell {
        static let reuseIdentifier = "CollectionViewCell"
        private let label = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }

        private func setup() {
            addSubview(label)
        }

        func configureCell(item: String) {
            label.text = item
            label.sizeToFit()
        }
    }
}

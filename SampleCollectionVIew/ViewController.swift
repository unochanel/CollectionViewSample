//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tagList = ["タグ作成", "😝眠い", "🍖食事", "😝残業", "😝仕事", "😝７文字のタグだ", "😝睡眠", "😝勉強", "😝７文字のタグだ", "😝８文字のタグです",  "😝８文字のタグです", "😝７文字のタグだ", "😝９文字はいるタグだ", "😝９文字はいるタグだ", "😝１０文字の場合は1個", "😝6文字の場合は", "😝仕事", "😝７文字のタグだ", "😝眠い", "🍖食事", "😝残業", "😝仕事", "😝iiii"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension ViewController {
    private func configure() {
        collectionView.dataSource = self
        configureCell()
        configureCollctionView()
    }
    
    private func configureCell() {
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    private func configureCollctionView() {
        let tagCellLayout = TagCellLayout(delegate: self)
        collectionView?.collectionViewLayout = tagCellLayout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.configureCell(item: tagList[indexPath.row])
        return cell
    }
}

extension ViewController: TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let label = UILabel()
        let view = UIView()
        label.text = tagList[index]
        label.sizeToFit()
        view.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 25)
        let cellSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        return cellSize
    }
}

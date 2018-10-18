//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tagList = ["タグ作成", "眠い", "食事", "残業", "仕事", "睡眠", "勉強","７文字のタグだ", "８文字のタグです", "７文字のタグだ"]

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
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
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

extension ViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        let view = UIView()
        label.text = tagList[indexPath.row]
        label.sizeToFit()
        view.frame.size = CGSize(width: label.frame.size.width + 24, height: label.frame.size.height + 20)
        let cellSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        return cellSize
    }
}

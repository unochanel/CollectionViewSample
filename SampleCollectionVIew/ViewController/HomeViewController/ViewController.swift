//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    var tagList = [TagResponse.Tag]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension ViewController {
    func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        getTagList()
        configureCell()
        configureCollctionView()
    }
    
    func configureCell() {
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func configureCollctionView() {
        let tagCellLayout = TagCellLayout(delegate: self)
        collectionView?.collectionViewLayout = tagCellLayout
    }
    
    func getTagList() {
        TagRequest().getTag(handler: { [weak self] tagResponse in
            guard let weakSelf = self else { return }
            weakSelf.tagList = tagResponse.tag
            weakSelf.collectionView.reloadData()
        })
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        guard let cellType = CellType(rawValue: tagList[indexPath.row].type) else { return }
        //タップされているかを、borderのWidthでハンドリングしている
        guard cell.label.layer.borderWidth == 0 else {
            cell.tappedTag(cellType: cellType)
            return
        }
        cell.configureLabelLayer(cellType: cellType)
    }
}

extension ViewController: TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let label = UILabel()
        label.text = tagList[index].tag
        label.sizeToFit()
        let cellSize = CGSize(width: label.frame.size.width + 24, height: label.frame.size.height + 20)
        return cellSize
    }
}

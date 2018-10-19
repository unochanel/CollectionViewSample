//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var tagList = [TagResponse.Tag]()
    private var tappedTag = [String]()
    private var tagtext: String!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        getTagList()
        configureCell()
        configureCollctionView()
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
        let tagList = self.tagList[indexPath.row]
        if tagList.tag == "タグ作成" {
            presentTextFieldAlertViewController()
        }
        
        guard let cellType = CellType(rawValue: tagList.type) else { return }
        guard let deleteTagIndex = tappedTag.index(of: tagList.tag) else {
            tappedTag.append(tagList.tag)
            cell.tappedTag(cellType: cellType)
            return
        }
        cell.configureLabelLayer(cellType: cellType)
        tappedTag.remove(at: deleteTagIndex)
    }
}

extension ViewController: TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        //TODO:もっと綺麗にCellの大きさを決めれそう
        let label = UILabel()
        label.text = tagList[index].tag
        label.sizeToFit()
        let cellSize = CGSize(width: label.frame.size.width + 24, height: label.frame.size.height + 24)
        return cellSize
    }
}


extension ViewController {
    private func configureCell() {
        collectionView.register(UINib(nibName: Cell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    private func configureCollctionView() {
        let tagCellLayout = TagCellLayout(delegate: self)
        collectionView?.collectionViewLayout = tagCellLayout
    }
    
    private func getTagList() {
        TagRequest().getTag(handler: { [weak self] tagResponse in
            guard let weakSelf = self else { return }
            weakSelf.tagList = tagResponse.tag
            weakSelf.collectionView.reloadData()
        })
    }
    
    private func presentTextFieldAlertViewController() {
        AlertController.shared.showAddTextFieldAlertViewController(
            title: "タグを作成する",
            message: "10文字以内でタグを作成する",
            fromViewController: self,
            completion: { text in
                guard let text = text else { return }
                self.tagtext = text
                self.dismiss(animated: false)
                self.presentCreateTagViewController()
        })
    }
    
    private func presentCreateTagViewController() {
        let viewController = CreateTagViewController.make()
        print(self.tagtext)
        present(viewController, animated: false)
    }
}

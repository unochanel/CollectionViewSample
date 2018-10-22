//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

struct TagList {
    let type: String
    let tag: String
}

final class ViewController: UIViewController {
    private var tagList = [TagList]()
    private var tappedTag = [String]()
    private var tagtext: String!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        let cellType = switchCellType(cellType: tagList[indexPath.row].type)
        cell.configureCell(cellType: cellType, text: tagList[indexPath.row].tag)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        let tagList = self.tagList[indexPath.row]
        guard tagList.tag != "タグ作成" else {
            presentTextFieldAlertViewController()
            return
        }
        
        let cellType = switchCellType(cellType: tagList.type)
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

extension ViewController: TappedButtonDelegateProtocol {
    func tappedCreateButtonDelegateProtocol() {
        tagList.removeAll()
        tagList = CreateManeger.shared.all()
        collectionView.reloadData()
    }
}

extension ViewController {
    private func configureCell() {
        collectionView.register(UINib(nibName: Cell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
    }
    
    private func configureCollctionView() {
        let tagCellLayout = TagCellLayout(delegate: self)
        collectionView?.collectionViewLayout = tagCellLayout
    }
    
    private func getTagList() {
        TagRequest().getTag(handler: { [weak self] tagResponse in
            guard let weakSelf = self else { return }
            _ = tagResponse.tag.map { CreateManeger.shared.append(TagList(type: $0.type, tag: $0.tag)) }
            weakSelf.tagList = CreateManeger.shared.all()
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
                guard text.count > 0 else { return }
                self.tagtext = text
                self.dismiss(animated: false)
                self.presentCreateTagViewController(text: text)
        })
    }
    
    private func presentCreateTagViewController(text: String) {
        let viewController = CreateTagViewController.make(text: text, delegate: self)
        present(viewController, animated: true)
    }
    
    private func switchCellType(cellType: String) -> CellType {
        switch cellType{
        case "positive": return .positive
        case "negative": return .negative
        default: return .normal
        }
    }
}

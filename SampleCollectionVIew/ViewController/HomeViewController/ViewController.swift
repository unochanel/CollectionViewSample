//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var tagList = [TagList]()
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
    @IBAction func registerTagButton(_ sender: Any) {
        print(tappedTag)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //一度タップされているかで、色を変えている。
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        let cellType = switchCellType(cellType: tagList[indexPath.row].type)
        guard tappedTag.contains(tagList[indexPath.row].type) else {
            cell.configureCell(cellType: cellType, text: tagList[indexPath.row].tag)
            return cell
        }
        cell.tappedTag(cellType: cellType)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        let createingTag = CreateManeger.shared.all()[indexPath.row]
        //メモを作成が押された場合の処理をしている
        guard indexPath.row != 0 else {
            presentTextFieldAlertViewController()
            return
        }
        
        let cellType = switchCellType(cellType: createingTag.type)
        guard createingTag.tapped else {
            CreateManeger.shared.tapped(index: indexPath.row)
            cell.tappedTag(cellType: cellType)
            return
        }
        cell.configureLabelLayer(cellType: cellType)
        CreateManeger.shared.tapped(index: indexPath.row)
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
        tagList = CreateManeger.shared.all()
        collectionView.reloadData()
    }
}

extension ViewController {
    private func configureCell() {
        collectionView.register(UINib(nibName: Cell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 130, left: 0, bottom: 0, right: 0)
    }
    
    private func configureCollctionView() {
        let tagCellLayout = TagCellLayout(delegate: self)
        collectionView?.collectionViewLayout = tagCellLayout
    }
    
    private func getTagList() {
        TagRequest().getTag(handler: { [weak self] tagResponse in
            guard let weakSelf = self else { return }
            _ = tagResponse.tag.map { tag in
                let createingTag = TagList(type: tag.type,
                                      tag: tag.tag,
                                      tappedDate: tag.date ?? Date(),
                                      tapped: false)
                CreateManeger.shared.append(createingTag)
            }
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
                self.dismiss(animated: true)
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

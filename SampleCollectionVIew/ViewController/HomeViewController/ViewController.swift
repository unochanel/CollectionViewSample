//
//  ViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/17.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
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
        print(CreateManeger.shared.all().filter { $0.tapped == true}.map { $0.tag })
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CreateManeger.shared.all().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        let creatingTag = CreateManeger.shared.all()[indexPath.row]
        cell.configureCell(creatingTag: creatingTag)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        guard indexPath.row != 0 else {
            presentTextFieldAlertViewController()
            return
        }
        CreateManeger.shared.tapped(index: indexPath.row)
        cell.configureCell(creatingTag: CreateManeger.shared.all()[indexPath.row])
    }
}

extension ViewController: TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let tagList = CreateManeger.shared.all()
        let label = UILabel()
        label.text = tagList[index].tag
        label.sizeToFit()
        let cellSize = CGSize(width: label.frame.size.width + 24, height: label.frame.size.height + 24)
        return cellSize
    }
}

extension ViewController: TappedButtonDelegateProtocol {
    func tappedCreateButtonDelegateProtocol() {
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
                let createingTag = TagList(type: tag.type, tag: tag.tag, tapped: false)
                CreateManeger.shared.append(createingTag)
            }
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
                self.presentCreateTagViewController(text: text)
        })
    }
    
    private func presentCreateTagViewController(text: String) {
        let viewController = CreateTagViewController.make(text: text, delegate: self)
        present(viewController, animated: true)
    }
}

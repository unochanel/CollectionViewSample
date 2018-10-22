//
//  CreateTagViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class CreateTagViewController: UIViewController {
    static func make(text: String, delegate: ViewController) -> CreateTagViewController {
        let storyboard = UIStoryboard(name: "CreateTagViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateTagViewController") as! CreateTagViewController
        viewController.tagTitle = text
        viewController.tappedDelgate = delegate
        viewController.modalPresentationStyle = .overCurrentContext
        
        return viewController
    }
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var tappedDelgate: TappedButtonDelegateProtocol?
    
    private var selectedType: CellType = .normal
    private var tagTitle: String!
    private var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction private func registerButton(_ sender: Any) {
        CreateManeger.shared.append(TagList.init(type: selectedType.toEnglish(), tag: tagTitle))
        tappedDelgate?.tappedCreateButtonDelegateProtocol()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func backButton(_ sender: Any) {
        showActionSheetViewController()
    }
}

extension CreateTagViewController {
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TagViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TagViewCell.reuseIdentifier)
    }
}

extension CreateTagViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.negative.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagViewCell.reuseIdentifier, for: indexPath) as! TagViewCell
        switch indexPath.row {
        case 0:  cell.configureCell(cellType: .positive)
        case 1:  cell.configureCell(cellType: .normal)
        case 2:  cell.configureCell(cellType: .negative)
        default: return cell
        }
        return cell
    }
}

extension CreateTagViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TagViewCell
        cell.checkImageView.image = R.image.on()!
        selectedType = CellType(rawValue: indexPath.row) ?? .normal
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TagViewCell
        cell.checkImageView.image = R.image.off()!
    }
}

extension CreateTagViewController {
    private func showActionSheetViewController() {
        AlertController.shared.showActionTwoSection(
            title: "編集内容を破棄しますか？",
            defaultTitle: "破棄",
            otherTitle: "内容を保存する",
            fromViewController: self,
            completion: { [weak self] keep in
                guard let weakSelf = self else { return }
                guard keep else {
                    CreateManeger.shared.append(TagList.init(type: weakSelf.selectedType.toEnglish(), tag: weakSelf.tagTitle))
                    weakSelf.tappedDelgate?.tappedCreateButtonDelegateProtocol()
                    weakSelf.dismiss(animated: true, completion: nil)
                    return
                }
                weakSelf.dismiss(animated: true, completion: nil)
        })
    }
}

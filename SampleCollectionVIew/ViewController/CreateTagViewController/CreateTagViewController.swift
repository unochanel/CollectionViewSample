//
//  CreateTagViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class CreateTagViewController: UIViewController {
    static func make(text: String, delegate: TappedButtonDelegateProtocol?) -> CreateTagViewController {
        let storyboard = UIStoryboard(name: "CreateTagViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateTagViewController") as! CreateTagViewController
        viewController.tagTitle = text
        viewController.tappedDelgate = delegate
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = viewController
        return viewController
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var background: UIView!
    private var tappedDelgate: TappedButtonDelegateProtocol?

    private var selectedType: CellType = .normal
    private var tagTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
    }

    @IBAction private func registerButton(_ asender: Any) {
        saveTagList()
        self.dismiss(animated: true)
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
        cell.configureCell(cellType: CellType(rawValue: indexPath.row)!)
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

extension CreateTagViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayTransitionPresent()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayTransitionDismiss()
    }
}

extension CreateTagViewController {
    private func showActionSheetViewController() {
        AlertController.shared.showActionTwoSection(title: "編集内容を破棄しますか？", defaultTitle: "破棄",  otherTitle: "内容を保存する", fromViewController: self, completion: { [weak self] no in
            guard let weakSelf = self else { return }
            if no == false {
                weakSelf.saveTagList()
            }
            weakSelf.dismiss(animated: true)
        })
    }
    
    private func saveTagList() {
        let tagList = TagList.init(type: selectedType.toEnglish(), tag: tagTitle, tapped: true)
        CreateManeger.shared.createTag(tagList: tagList)
        tappedDelgate?.tappedCreateButtonDelegateProtocol()
    }
}

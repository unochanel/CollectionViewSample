//
//  CreateTagViewController.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

final class CreateTagViewController: UIViewController {
    static func make() -> CreateTagViewController {
        let storyboard = UIStoryboard(name: "CreateTagViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateTagViewController") as! CreateTagViewController
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var selectedType: CellType!
    private var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction private func registerButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        return CellType.negative.index + 1
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

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TagViewCell
        switch indexPath.row {
        case 0:  selectedType = .positive
        case 1:  selectedType = .normal
        case 2:  selectedType = .negative
        default:  return
        }
    }
}

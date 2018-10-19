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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        
    }

}

//
//  UIViewController+Ex.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertViewController(
        title: String? = nil,
        message: String? = nil,
        actionTitle: String? = "OK",
        handler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        
        present(alertController, animated: true)
    }
    
    func showAlertViewControllerTwoSelection(
        title: String? = nil,
        message: String? = nil,
        okSelectionTitle: String? = "OK",
        cancelSelectionTitle: String? = "Cancel",
        okHandler: ((UIAlertAction) -> ())? = nil,
        cancelHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okSelectionTitle, style: .default, handler: okHandler))
        alertController.addAction(UIAlertAction(title: cancelSelectionTitle, style: .cancel, handler: cancelHandler))
        present(alertController, animated: true)
    }
}

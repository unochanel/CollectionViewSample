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

public final class AlertController {
    public static let shared = AlertController()
    private init() {}
    
    public func showAddTextFieldAlertViewController(
        title: String? = nil,
        message: String? = nil,
        okSelectionTitle: String? = "OK",
        cancelSelectionTitle: String? = "Cancel",
        fromViewController: UIViewController,
        completion: ((String?) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.keyboardType = .namePhonePad
            textField.checkCount(max: 10)
        }
        alertController.addAction(UIAlertAction(title: okSelectionTitle, style: .default, handler: {(_: UIAlertAction) -> Void in
            completion?(alertController.textFields?[0].text)
        }))
        alertController.addAction(UIAlertAction(title: cancelSelectionTitle, style: .cancel, handler:  {(_: UIAlertAction) -> Void in
            completion?(nil)
        }))
        fromViewController.present(alertController, animated: true)
    }

    public func showActionTwoSection(title: String? = nil, message: String? = nil ,
                              defaultTitle: String, otherTitle: String,
                              fromViewController: UIViewController,
                              completion: ((Bool) -> Void)?) {
        
        let actionController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: defaultTitle, style: .destructive, handler: { (_: UIAlertAction) -> Void in
            completion?(true)
        }))
        actionController.addAction(UIAlertAction(title: otherTitle, style: .default, handler: { (_: UIAlertAction) -> Void in
            completion?(false)
        }))
        actionController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in})
        
        fromViewController.present(actionController, animated: true, completion: nil)
    }

}

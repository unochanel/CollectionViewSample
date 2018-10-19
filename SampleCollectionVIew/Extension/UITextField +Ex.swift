//
//  UITextField.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/19.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

extension UITextField {
    func checkCount(max: Int) {
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let value: String = textField.text!
        
        let alertController: UIAlertController = textField.parentAlertController()!
        
        let originalX: CGFloat = alertController.view.frame.origin.x
        
        if value == "" || value.count > 10 {
            
            if textField.tag == 1 { return }
            textField.tag = 1
            
            alertController.actions[1].isEnabled = false
            alertController.view.frame.origin.x = originalX + 4
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                alertController.view.frame.origin.x = originalX - 4
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                alertController.view.frame.origin.x = originalX + 4
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                alertController.view.frame.origin.x = originalX
                textField.tag = 0
            }
            App.shortVibrate()
        } else {
            alertController.actions[1].isEnabled = true
        }
    }
}

//
//  UIViewControllerExtension.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/22.
//

import UIKit

// MARK: Hide Keyboard When Tapped Around
extension UIViewController {
  func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool) {
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(hideKeyboard))
    
    tapGesture.cancelsTouchesInView = cancelsTouchesInView
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    view.endEditing(true)
  }
}

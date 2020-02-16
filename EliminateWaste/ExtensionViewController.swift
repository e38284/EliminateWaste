//
//  ExtensionViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/01/15.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit

// MARK: - UISearchBar
extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return value(forKey: "_searchField") as? UITextField
        }
    }
}
extension UITextField {
    //虫眼鏡
    var lupeImageView: UIImageView? {
        return leftView as? UIImageView
    }
}
extension UIImageView {
  func becomeImageAlwaysTemplate() {
    image = image?.withRenderingMode(.alwaysTemplate)
  }
}

class ExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

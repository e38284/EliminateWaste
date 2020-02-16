//
//  MainPageViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2019/12/26.
//  Copyright © 2019 YutaroHagiwara. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Extension
// Specify the background color by tapping UIButton with UIColor
// Create a UIImage from UIColor and set it to setBackgroundImage.
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let image = color.image
        setBackgroundImage(image, for: state)
    }
}
extension UIColor {
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


class MainPageViewController: UIViewController {
    // MARK: - Instance
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var urineButton: UIButton!
    @IBOutlet weak var fecalButton: UIButton!
    @IBOutlet weak var injectionButton: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        // MARK: - UIButton
        // When UIButton is pressed, specify background color with UIColor
        let mainColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        foodButton.setBackgroundColor(mainColor , for: .highlighted)
        urineButton.setBackgroundColor(mainColor , for: .highlighted)
        fecalButton.setBackgroundColor(mainColor , for: .highlighted)
        injectionButton.setBackgroundColor(mainColor , for: .highlighted)
        emergencyButton.setBackgroundColor(mainColor , for: .highlighted)
    }
    // MARK: - UINavigationController
    // Hide NavigationController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // Display NavigationController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


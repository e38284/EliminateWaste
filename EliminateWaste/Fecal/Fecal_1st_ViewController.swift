//
//  Fecal_1st_ViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/02/05.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit

class Fecal_1st_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - NavigationBar
        // Change text in navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [
        // Change text color
            .foregroundColor: UIColor(red: 51/255, green: 89/255, blue: 121/255, alpha: 1)
        ]
        // Hide UINavigationBar back button text(NextViewController)
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

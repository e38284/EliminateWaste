//
//  CoefficientViewController.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/01/08.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit

class CoefficientViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var segmentWord = ""
    var imageWord = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - UIImageView
        // Conditional branch with SegmentWord of previous screen
        if segmentWord == "canine" {
            imageWord = "Coefficient_Canine"
        } else if segmentWord == "feline" {
            imageWord = "Coefficient_Feline"
        }
        // Load image, set image loaded in Image View
        let image = UIImage(named: imageWord)
        imageView.image = image
    }
}

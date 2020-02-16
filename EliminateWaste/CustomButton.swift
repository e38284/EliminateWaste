//
//  CustomButton.swift
//  EliminateWaste
//
//  Created by YutaroHagiwara on 2020/01/01.
//  Copyright © 2020 YutaroHagiwara. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    // Radius of rounded corner (0 is square)
    @IBInspectable var cornerRadius: CGFloat = 0.0
    // frame
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0.0

    override func draw(_ rect: CGRect) {
        // Rounded corner
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        // Frame border
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        super.draw(rect)
    }
}

//
//  RoundButton.swift
//  Left
//
//  Created by Alejandrina Patron on 4/8/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

@IBDesignable public class RoundButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
    }
}

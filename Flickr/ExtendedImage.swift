//
//  ExtendedImage.swift
//  Flickr
//
//  Created by KBryan on 2015-11-04.
//  Copyright © 2015 KBryan. All rights reserved.
//

import UIKit

@IBDesignable

class ExtendedImage: UIImageView {
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true

        }
        willSet {
            layer.cornerRadius = self.frame.width / 2
            layer.borderColor = UIColor.whiteColor().CGColor
            
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
        willSet {
            layer.borderWidth = 5
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.whiteColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
        willSet {
            layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
}

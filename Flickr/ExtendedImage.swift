//
//  ExtendedImage.swift
//  Flickr
//
//  Created by KBryan on 2015-11-04.
//  Copyright © 2015 KBryan. All rights reserved.
//

import UIKit


class ExtendedImage: UIImageView {
    
    override func layoutSublayersOfLayer(layer: CALayer) {

        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        layer.borderWidth = 5
        layer.borderColor = UIColor.whiteColor().CGColor
    
    }

}

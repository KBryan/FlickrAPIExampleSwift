//
//  ViewController.swift
//  Flickr
//
//  Created by KBryan on 2015-11-04.
//  Copyright © 2015 KBryan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var photoTitle: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    var myFlickrModel: FlickModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFlickrModel = FlickModel(photoView: photoImageView, myTitle: photoTitle)
    }

    @IBAction func getNextImage(sender: AnyObject) {
        myFlickrModel.getImageFromFlickr()
    }
}


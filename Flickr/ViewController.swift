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
    var myFlickrModel:Flick_Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          myFlickrModel = Flick_Model(photoView: photoImageView, myTitle: photoTitle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func GetNextImage(sender: AnyObject) {
        myFlickrModel.getImageFromFlickr()

    }

}


//
//  ViewController.swift
//  FlickrApp
//
//  Created by Kwame Bryan on 2015-04-04.
//  Copyright (c) 2015 3e Interactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
        Gallery ID taken from Flickr API docs https://www.flickr.com/services/api/flickr.galleries.getList.html
    */
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    var myFlickrModel:Flick_Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myFlickrModel = Flick_Model(photoView: photoImageView, myTitle: photoTitle)
    }
    @IBAction func touchRefreshButton(sender: AnyObject) {
        
        myFlickrModel.getImageFromFlickr()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  Flick_Model.swift
//  FlickrApp
//
//  Created by KBryan on 2015-11-04.
//  Copyright © 2015 3e Interactive. All rights reserved.
//

import UIKit

class Flick_Model: NSObject {
    
    private var photoImageView:UIImageView!
    private var photoTitle:UILabel!
    
    init(photoView:UIImageView,myTitle:UILabel) {
        photoImageView = photoView
        photoTitle = myTitle
    }

    func getImageFromFlickr() {
        
        
        /*
        Returns a shared singleton session object.
        The shared session uses the currently set global NSURLCache, NSHTTPCookieStorage, and NSURLCredentialStorage objects and is based on the default configuration.
        */
        let session = NSURLSession.sharedSession()
        let urlString = BASE_URL + escapedParameters(METHOD_ARGUMENTS)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        /* 4 - Initialize task for getting data */
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError {
                print("Could not complete the request \(error)")
            } else {
                /* 5 - Success! Parse the data */
                
                var parsingError: NSError? = nil
                let parsedResult: AnyObject!
                do {
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                } catch let error as NSError {
                    parsingError = error
                    print("\(parsingError)")
                    parsedResult = nil
                } catch {
                    fatalError()
                }
                
                if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {
                        
                        /* 6 - Grab a single, random image */
                        let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                        let photoDictionary = photoArray[randomPhotoIndex] as [String: AnyObject]
                        
                        /* 7 - Get the image url and title */
                        let photoTitle = photoDictionary["title"] as? String
                        let imageUrlString = photoDictionary["url_m"] as? String
                        let imageURL = NSURL(string: imageUrlString!)
                        
                        /* 8 - If an image exists at the url, set the image and title */
                        if let imageData = NSData(contentsOfURL: imageURL!) {
                            ///Submits a block for asynchronous execution on a dispatch queue and returns immediately.
                            dispatch_async(dispatch_get_main_queue(), {
                                self.photoImageView.image = UIImage(data: imageData)
                                self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width  / 2;
                                self.photoImageView.clipsToBounds = true;
                                self.photoImageView.layer.borderWidth = 10
                                self.photoImageView.layer.borderColor = UIColor.whiteColor().CGColor
                                self.photoTitle.text = photoTitle
                            })
                        } else {
                            print("Image does not exist at \(imageURL)")
                        }
                    } else {
                        print("Cant find key 'photo' in \(photosDictionary)")
                    }
                } else {
                    print("Cant find key 'photos' in \(parsedResult)")
                }
            }
        }
        /* 9 - Resume (execute) the task */
        task.resume()
    }
    
    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            /// used _ to ignore value
            _ = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* FIX: Replace spaces with '+' */
            _ = stringValue.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            /* Append it */
            urlVars += [key + "=" + "\(value)"]
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }

}

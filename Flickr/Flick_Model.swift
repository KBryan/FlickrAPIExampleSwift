import UIKit

class FlickModel {
    
    private var _photoImageView: UIImageView!
    private var _photoTitle: UILabel?
    
    typealias JSONType = [String : AnyObject]
    /// Flickr_Model Initializor
    ///
    /// param1: passes a UIImage to be updated on the view
    /// param2: passes a UILabel to be updated on the view
    init(photoView: UIImageView, myTitle: UILabel) {
        _photoImageView = photoView
        _photoTitle = myTitle
    }
    
    init(photoView: UIImageView) {
        _photoImageView = photoView
    }
    
    /// Get an Image from the Flickr API
    ///
    /// takes no parameter and returns nothing
    func getImageFromFlickr()
    {
        // STep one create a session
        let session = NSURLSession.sharedSession()
        
        // create a URL String
        let urlString = BASE_URL + FlickModel.escapedParameters(METHOD_ARGUMENTS)
        guard let url = NSURL(string: urlString) else { return }
        
        // create a URL Request
        let request = NSURLRequest(URL: url)
        print(request)
        // Initialize task for getting data
        let task = session.dataTaskWithRequest(request) { data , response, downloadError in
            // check is we are successful
            
            if let error = downloadError {
                print("could not complete request \(error)")
            } else {
                // we are successful
                var parseError:NSError? = nil
                let parsedResult:AnyObject!
                do {
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                } catch let error as NSError {
                    parseError = error
                    print("\(parseError)")
                    parsedResult = nil
                } catch {
                    fatalError()
                }
                
                guard let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary else {
                    print("cant find key parsed result")
                    return
                }
                
                guard let photoArray = photosDictionary.valueForKey("photo") as? [JSONType] else {
                    print("can't find key photo")
                    return
                }
                
                let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                let photoDictionary = photoArray[randomPhotoIndex] as JSONType
                
                /// grab the image url and title
                guard let photoTitle = photoDictionary["title"] as? String,
                    let imageUrlString = photoDictionary["url_m"] as? String,
                    let imageURL = NSURL(string: imageUrlString),
                    let imageData = NSData(contentsOfURL: imageURL) else {
                        print("Image does not exist")
                        return
                }
                
                dispatch_async(dispatch_get_main_queue()){ [unowned self] in
                    /// set the image and the title for the view
                    self._photoImageView.image = UIImage(data: imageData)
                    self._photoImageView.clipsToBounds = true
                    self._photoTitle?.text = photoTitle
                }
            }
        }
        
        task.resume()
    }
    
    /// Helper function: Takes a dictionary and returns a string
    ///
    /// Given a dictionary of parameters / and convert a string for url
    class func escapedParameters(parameters: JSONType) ->String {
        var urlVars = [String]()
        
        for (key,value) in parameters {
            // make sure that it is a string
            let stringValue = "\(value)"
            _ = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            _ = stringValue.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            // append it
            urlVars += [key + "=" + "\(value)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
}

//
//  Constants.swift
//  FlickrApp
//
//  Created by KBryan on 2015-11-04.
//  Copyright © 2015 3e Interactive. All rights reserved.
//

import Foundation

/**
Define Constants
*/
let BASE_URL = "https://api.flickr.com/services/rest/"
let METHOD_NAME = "flickr.galleries.getPhotos"
let API_KEY = "aa7ecb68a8182355cbba8ddfb3d7ff64"
let GALLERY_ID = "5704-72157622637971865"
let EXTRAS = "url_m"
let DATA_FORMAT = "json"
let NO_JSON_CALLBACK = "1"
/* 2 - API method arguments */
let METHOD_ARGUMENTS = [
    "method": METHOD_NAME,
    "api_key": API_KEY,
    "gallery_id": GALLERY_ID,
    "extras": EXTRAS,
    "format": DATA_FORMAT,
    "nojsoncallback": NO_JSON_CALLBACK
]
/* 3 - Initialize session and url */
// changed from session



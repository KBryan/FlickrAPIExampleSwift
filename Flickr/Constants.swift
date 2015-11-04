
import Foundation

let BASE_URL = "https://api.flickr.com/services/rest"
let METHOD_NAME = "flickr.galleries.getPhotos"
let API_KEY = "aa7ecb68a8182355cbba8ddfb3d7ff64"
let GALLERY_ID = "5704-72157622637971865"
let EXTRAS = "url_m"
let DATA_FORMAT = "json"
let NO_JSON_CALLBACK = "1"

// API Method arguments
let METHOD_ARGUMENTS = [
    "method":METHOD_NAME,
    "api_key": API_KEY,
    "gallery_id":GALLERY_ID,
    "extras":EXTRAS,
    "format":DATA_FORMAT,
    "nojsoncallback":NO_JSON_CALLBACK
]
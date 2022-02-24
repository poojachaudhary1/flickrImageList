//
//  Constants.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import Foundation
import UIKit

enum Constants {
    static let apiKey = "96358825614a5d3b1a1c3fd87fca2b47"
    static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=kittens&format=json&nojsoncallback=1&page=%@"
    static let downloadImageURL = "http://farm%@.static.flickr.com/%@/%@_%@.jpg"
    static let footerViewHeight: CGFloat = 50
}

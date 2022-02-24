//
//  FlickImageListViewModel.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import Foundation
import Alamofire

class FlickrImageListViewModel {
    var flickrImageData: FlickrImageData?
    var flickrImageList: [FlickrImageModel] = [FlickrImageModel]() {
        didSet {
            loadResponseData?()
        }
    }
    var loadResponseData: (() -> Void)?
    var nextPage: Int? {
        guard let pages = flickrImageData?.data?.pages else {
            return nil
        }
        if let page = flickrImageData?.data?.page, page+1 <= pages {
            return page+1
        }
        return nil
    }
    func loadFlickrImages(page: Int = 1, completion: ((Bool) -> Void)? = nil) {
        let url = String(format: Constants.searchURL, "\(page)")
        AF.request(url, method: .get).responseDecodable(of: FlickrImageData.self) { [weak self] response in
            guard let flickrImageData = response.value else {
                completion?(false)
                return
            }
            self?.flickrImageData = flickrImageData
            self?.flickrImageList.append(contentsOf: flickrImageData.data?.photoList ?? [])
            completion?(true)
        }
    }
}

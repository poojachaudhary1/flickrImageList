//
//  FlickrImageListModel.swift
//  FlickrImageList
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import Foundation

struct FlickrImageData: Decodable {
    let data: FlickrImageListModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "photos"
    }
}
struct FlickrImageListModel: Decodable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photoList: [FlickrImageModel]?
    
    enum CodingKeys: String, CodingKey {
        case page, pages, perpage, total
        case photoList = "photo"
    }
}
struct FlickrImageModel: Decodable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
    }
}

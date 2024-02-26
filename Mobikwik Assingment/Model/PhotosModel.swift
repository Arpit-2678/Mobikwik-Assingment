//
//  PhotosModel.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 25/02/24.
//

import Foundation

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
}

struct PhotosModel: Codable {
    let photos: PhotosData
    let stat: String
    
    private enum CodingKeys: String, CodingKey {
        case photos, stat
    }
}

struct PhotosData: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: Int
    let photo: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case page, pages, total, photo
        case perPage = "perpage"
    }
}

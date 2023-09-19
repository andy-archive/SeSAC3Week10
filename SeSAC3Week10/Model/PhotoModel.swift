//
//  PhotoModel.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import Foundation

struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}

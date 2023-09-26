//
//  PhotoModel.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import Foundation

struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}

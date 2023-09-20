//
//  PunkModel.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import Foundation

struct Punk: Decodable {
    let id: Int
    let name, tagline, firstBrewed, description: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
    }
}

typealias Punks = [Punk]

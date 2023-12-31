//
//  UnsplashAPI.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import Foundation
import Alamofire

enum UnsplashAPI {
    
    private static let accessKey = APIKey.accessKey
    private static let secretKey = APIKey.secretKey
    
    case search(query: String)
    case random
    case photo(id: String)
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return [
            "Authorization": "Client-ID \(UnsplashAPI.accessKey)"
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo:
            return ["": ""]
        }
    }
}


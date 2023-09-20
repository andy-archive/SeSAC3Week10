//
//  PunkNetwork.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import Foundation
import Alamofire

enum PunkAPI {
    
    case beers(query: String)
    case singleBeer(id: String)
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/"
    }
    
    var endpoint: URL {
        switch self {
        case .beers:
            return URL(string: baseURL + "beers/")!
        case .singleBeer(let id):
            return URL(string: baseURL + "\(id)")!
        case .randomBeer:
            return URL(string: baseURL + "")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .beers(let query):
            return ["query": query]
        case .singleBeer, .randomBeer:
            return ["": ""]
        }
    }
}

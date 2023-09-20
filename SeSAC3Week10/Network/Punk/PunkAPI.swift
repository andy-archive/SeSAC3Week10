//
//  PunkAPI.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import Foundation
import Alamofire

enum PunkAPI: URLRequestConvertible {
    
    case beers(query: String)
    case singleBeer(id: String)
    case randomBeer
    
    private var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/")!
    }
    
    private var path: String {
        switch self {
        case .beers:
            return "beers/"
        case .singleBeer(let id):
            return "\(id)"
        case .randomBeer:
            return "beers/random"
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
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.method = method
        
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        return request
    }
}

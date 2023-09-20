//
//  PunkNetwork.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import Foundation
import Alamofire

final class PunkNetwork {
    
    static let shared = PunkNetwork()
    
    private init() {}
    
    func requestRandomBeer<T: Decodable>(type: T.Type, API: PunkAPI, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(API)
            .validate(statusCode: 200...299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = NetworkError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error))
                }
            }
    }
}


//
//  Network.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import Foundation
import Alamofire

final class Network {
    
    static let shared = Network()
    
    private let key = APIKey.accessKey
    
    private init() {}
    
    func request<T: Decodable>(type: T.Type, API: UnsplashAPI, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        AF.request(API.endpoint, method: API.method, parameters: API.query, encoding: URLEncoding(destination: .queryString), headers: API.header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data as! T))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = NetworkError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error))
                }
            }
    }
    
    func getDetailPhoto(API: UnsplashAPI, photoID: String, completionHandler: @escaping (Result<PhotoResult, Error>) -> Void) {

        AF.request(API.endpoint, method: API.method, headers: API.header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: PhotoResult.self) { response in
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
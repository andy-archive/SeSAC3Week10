//
//  ImageDetailViewModel.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/20.
//

import UIKit

final class ImageDetailViewModel {
    
    func requestSearchPhotoRandomByConvertible(completionHandler: @escaping (URL) -> Void) {
        Network.shared.requestConvertible(type: PhotoResult.self, API: .random) { response in
            switch response {
            case .success(let success):
                completionHandler(URL(string: success.urls.thumb)!)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    func searchPhotos(query: String) {
        Network.shared.request(type: Photo.self, API: .search(query: query)) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    func getDetailPhoto(id: String) {
        Network.shared.request(type: PhotoResult.self, API: .photo(id: "")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
}

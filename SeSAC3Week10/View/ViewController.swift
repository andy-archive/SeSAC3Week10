//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    private var photoID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPhotos(query: "apple")
    }
    
    private func searchPhotos(query: String) {
        Network.shared.request(type: Photo.self, API: .search(query: query)) { response in
            switch response {
            case .success(let suceess):
                dump(suceess)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}

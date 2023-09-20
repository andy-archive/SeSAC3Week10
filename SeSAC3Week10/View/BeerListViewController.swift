//
//  BeerListViewController.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import UIKit

final class BeerListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        requestRandomBeerConvertible()
    }
    
    private func requestRandomBeerConvertible() {
        PunkNetwork.shared.requestRandomBeer(type: Punks.self, API: .randomBeer) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
}

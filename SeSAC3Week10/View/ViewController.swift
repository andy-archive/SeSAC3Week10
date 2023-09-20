//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import UIKit
import SnapKit
import Kingfisher

final class ViewController: UIViewController {
    
    private let scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green.withAlphaComponent(0.1)
        view.minimumZoomScale = 1
        view.maximumZoomScale = 3
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let viewModel = ImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
        
        configureHierarchy()
        configureLayout()
        configureGesture()
        
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel.requestSearchPhotoRandomByConvertible { url in
            self.imageView.kf.setImage(with: url)
        }
    }
    
    @objc
    private func doubleTappedGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTappedGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    private func configureDelegate() {
        scrollView.delegate = self
    }
        
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.6)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
            make.center.equalTo(scrollView)
        }
    }
    
}

//MARK: UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

/*
 
//MARK: Network (in MVC)
 
extension ViewController {

    private func reqeustSearchPhotoRandomByConvertible() {
        Network.shared.requestConvertible(type: PhotoResult.self, API: .random) { response in
            switch response {
            case .success(let success):
                //dump(success)
                self.imageView.kf.setImage(with: URL(string: success.urls.thumb)!)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    private func searchPhotos(query: String) {
        Network.shared.request(type: Photo.self, API: .search(query: query)) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    private func getDetailPhoto(id: String) {
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

*/

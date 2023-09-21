//
//  SearchCollectionViewCell.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import UIKit
import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        contentView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        
        label.text = "TEST"
        label.font = .systemFont(ofSize: 15)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(contentView).multipliedBy(0.6)
        }
        
        label.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

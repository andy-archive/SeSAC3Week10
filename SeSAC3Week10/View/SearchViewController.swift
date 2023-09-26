//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchViewController: UIViewController, UISearchBarDelegate {

    private var list = ["andy", "saboo", "UICollectionViewDiffableDataSource", "joey", "roen", "noah", "UICollectionViewCompositionalLayoutConfiguration"]
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!

    override func viewDidLoad() {
        super.viewDidLoad()

        //configureDelegate()
        
        configureDataSource()
        configureHierarchy()
        configureUI()
        configureLayout()
        
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UnsplashNetwork.shared.requestConvertible(type: Photo.self, API: .search(query: searchBar.text!)) { response in
            switch response {
            case .success(let success): // 데이터의 반영 & 스냅샷의 처리
                // load data + snapshot UI
                
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height) }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
                
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.configureSnapshot(success)

//                dump(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configureSnapshot(_ item: Photo) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item.results)
        dataSource.apply(snapshot)
    }
    
    func configureDataSource() {
        
        //1. CellRegistration
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb)!)
            cell.label.text = "\(itemIdentifier.created_at)"
        }
        
        //2. UICollectionViewDiffableDataSource
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }

    private func configureDelegate() {
        //collectionView.delegate = self
        //collectionView.dataSource = self
    }

    private func configureHierarchy() {
        view.addSubview(collectionView)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    private func configureUI() {
        view.backgroundColor = .white
    }

    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configurePinterestLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
    private func configureTagLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(30)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }

    
    //UICollectionViewLayout
//    private func configureCollectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        let numberOfItem: CGFloat = 4
//        let sectionSpacing: CGFloat = 8
//        let itemSpacing: CGFloat = 12
//
//        layout.minimumLineSpacing = itemSpacing
//        layout.minimumInteritemSpacing = itemSpacing
//        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
//
//        let size = UIScreen.main.bounds.width - sectionSpacing * 2 - itemSpacing * (numberOfItem - 1)
//
//        layout.itemSize = CGSize(width: size / numberOfItem, height: size / numberOfItem)
//
//        return layout
//    }
}

//MARK: UIScrollViewDelegate

extension SearchViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//        print(scrollView.contentOffset.x)
//        print(scrollView.contentOffset.y)
//        print("")

        if scrollView.contentOffset.y >= 50 {
            //label.alpha = 0
        }
    }
}

/*
 
 //MARK: UICollectionViewDelegate, UICollectionViewDataSource

 extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return list.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
         cell.label.text = "\(list[indexPath.item]) 번"
         return cell
     }
 }

 //MARK: UIScrollView & Vertical Scroll

 private let scrollView = UIScrollView()
 private let contentView = UIView()
 private let thumbnailImageView = UIImageView()
 private let descriptionLabel = UILabel()
 private let updateButton = UIButton()

 override func viewDidLoad() {
     super.viewDidLoad()

     configureHierarchy()
     configureUI()
     configureLayout()
     configureContentView()
 }

 private func configureHierarchy() {
     view.addSubview(scrollView)
     scrollView.addSubview(contentView)

 }

 private func configureUI() {
     view.backgroundColor = .white
     scrollView.backgroundColor = .gray
 }

 private func configureLayout() {
     //scrollView.bounces = false
     scrollView.showsVerticalScrollIndicator = false
     scrollView.backgroundColor = .cyan.withAlphaComponent(0.2)
     scrollView.snp.makeConstraints { make in
         make.edges.equalTo(view.safeAreaLayoutGuide)
     }

     contentView.backgroundColor = .systemRed.withAlphaComponent(0.3)
     contentView.snp.makeConstraints { make in
         make.verticalEdges.equalTo(scrollView)
         make.width.equalTo(scrollView.snp.width)
     }
 }

 private func configureContentView() {
     contentView.addSubview(thumbnailImageView)
     contentView.addSubview(descriptionLabel)
     contentView.addSubview(updateButton)

     thumbnailImageView.backgroundColor = .orange.withAlphaComponent(0.8)
     updateButton.backgroundColor = .magenta.withAlphaComponent(0.9)
     descriptionLabel.backgroundColor = .systemGreen.withAlphaComponent(0.7)


     thumbnailImageView.snp.makeConstraints { make in
         make.top.horizontalEdges.equalTo(contentView).inset(10)
         make.height.equalTo(200)
     }

     updateButton.snp.makeConstraints { make in
         make.bottom.horizontalEdges.equalTo(contentView).inset(10)
         make.height.equalTo(80)
     }

     descriptionLabel.text = "Lorem ipsum dolor \nsit amet,\n consectetur adipiscing elit,\n sed do eiusmod\n tempor\n incididunt ut labore et dolore magna aliqua.\n Ut enim ad minim veniam, quis nostrud exercitation \nullamco laboris nisi ut aliquip ex ea\n commodo consequat.\n Duis aute irure dolor \nin reprehenderit in voluptate velit esse \ncillum dolore eu \nfugiat nulla pariatur.\n Excepteur sint occaecat cupidatat\n non proident, sunt in culpa qui officia \ndeserunt mollit anim id est laborum."
     descriptionLabel.textColor = .white
     descriptionLabel.numberOfLines = 0
     descriptionLabel.snp.makeConstraints { make in
         make.horizontalEdges.equalTo(contentView)//.inset(10)
         make.top.equalTo(thumbnailImageView.snp.bottom).offset(50)
         make.bottom.equalTo(updateButton.snp.top).offset(-50)

     }
 }

 //MARK: UIStackView & Horizontal Scroll

final class SearchViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        configureDelegate()
        configureHierarchy()
        configureUI()
        configureLayout()
        configureStackView()
//        configureGesture()
//        configureViewModel()
    }


    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

    }

    private func configureUI() {
        view.backgroundColor = .white
        scrollView.backgroundColor = .lightGray

    }

    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }

        stackView.backgroundColor = .brown
        stackView.spacing = 20
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(70)
        }
    }

    private func configureStackView() {
        let greetingsLabel = UILabel()
        greetingsLabel.text = "Hey Nice to Meet You :)"
        greetingsLabel.textColor = .white
        greetingsLabel.backgroundColor = .systemRed
        stackView.addArrangedSubview(greetingsLabel)

        let searchLabel = UILabel()
        searchLabel.text = "Type text to search"
        searchLabel.textColor = .white
        searchLabel.backgroundColor = .systemGreen
        stackView.addArrangedSubview(searchLabel)

        let hotSearchLabel = UILabel()
        hotSearchLabel.text = "Today's Hot Item"
        hotSearchLabel.textColor = .white
        hotSearchLabel.backgroundColor = .systemBlue
        stackView.addArrangedSubview(hotSearchLabel)

        let exampleLabel = UILabel()
        exampleLabel.text = "This is an Example"
        exampleLabel.textColor = .white
        exampleLabel.backgroundColor = .magenta
        stackView.addArrangedSubview(exampleLabel)
    }
}
*/

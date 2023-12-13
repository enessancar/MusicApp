//
//  HomeView.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import UIKit
import SnapKit

final class HomeView: UIView {
   
    //MARK: - Properties
    private lazy var discoverLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeView.discover
        label.font = .boldSystemFont(ofSize: FontSize.headline)
        return label
    }()
    
    lazy var browseButton: UIButton = {
        let button = UIButton()
        button.configuration?.cornerStyle = .capsule
        button.tintColor = .label
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        button.setTitle(Constants.HomeView.browse, for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var discoverStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [discoverLabel, browseButton])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    lazy var discoverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeView.genres
        label.font = .boldSystemFont(ofSize: FontSize.headline)
        return label
    }()
    
    lazy var exploreButton: UIButton = {
        let button = UIButton()
        button.configuration?.cornerStyle = .capsule
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        button.tintColor = .label
        button.setTitle(Constants.HomeView.explore, for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genresLabel, exploreButton])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var popularSongsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeView.popularSongs
        label.font = .boldSystemFont(ofSize: FontSize.headline)
        return label
    }()
    
    lazy var popularSongsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureDiscoverStackView()
        configureDiscoverCollectionView()
        configureGenresStackView()
        configureGenresCollectionView()
        configurePopularSongsLabel()
        configurePopularSongsTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureDiscoverStackView() {
        addSubview(discoverStackView)
   
        discoverStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureDiscoverCollectionView() {
        addSubview(discoverCollectionView)
        
        discoverCollectionView.snp.makeConstraints { make in
            make.top.equalTo(discoverStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
    }
    
    private func configureGenresStackView() {
        addSubview(genresStackView)
        
        genresStackView.snp.makeConstraints { make in
            make.top.equalTo(discoverCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureGenresCollectionView() {
        addSubview(genresCollectionView)
        
        genresCollectionView.snp.makeConstraints { make in
            make.top.equalTo(genresStackView.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(genresCollectionView)
        }
    }
    
    private func configurePopularSongsLabel() {
        addSubview(popularSongsLabel)
        
        popularSongsLabel.snp.makeConstraints { make in
            make.top.equalTo(genresCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func configurePopularSongsTableView() {
        addSubview(popularSongsTableView)
        
        popularSongsTableView.snp.makeConstraints { make in
            make.top.equalTo(popularSongsLabel.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

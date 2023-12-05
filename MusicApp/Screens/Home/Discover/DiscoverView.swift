//
//  DiscoverView.swift
//  MusicApp
//
//  Created by Enes Sancar on 5.12.2023.
//

import UIKit
import SnapKit

final class DiscoverView: UIView {
    
    //MARK: - Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        layout.minimumInteritemSpacing = .zero
        
        let collectionView = UICollectionView()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureCollectionView() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
    }
}

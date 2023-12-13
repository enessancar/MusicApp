//
//  GenreArtistsVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit
import SnapKit

final class GenreArtistsVC: UIViewController {
    
    let genreArtistView = GenreArtistsView()
    let viewModel: GenreArtistsViewModel?
    
    init(genreId: String, manager: DeezerAPIManager) {
        self.viewModel = GenreArtistsViewModel(genreId: genreId, manager: manager)
        super.init(nibName: nil, bundle: nil)
        viewModel?.delegate = self
        addDelegatesAndDataSources()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(genreArtistView)
        genreArtistView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addDelegatesAndDataSources() {
        genreArtistView.collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        genreArtistView.collectionView.dataSource = self
        genreArtistView.collectionView.delegate = self
    }
}

extension GenreArtistsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel {
            if let response = viewModel.data {
                if let artists = response.data {
                    return artists.count
                }
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else {
            fatalError()
        }
        if let viewModel {
            if let response = viewModel.data {
                if let artists = response.data {
                    cell.updateUI(artist: artists[indexPath.item])
                }
            }
        }
        return cell
    }
    
     
}


extension GenreArtistsVC: GenreArtistsViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.genreArtistView.collectionView.reloadData()
        }
    }
}

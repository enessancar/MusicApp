//
//  GenresVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 9.12.2023.
//

import UIKit
import SnapKit

final class GenresVC: UIViewController {
    
    lazy var genresView = GenresView()
    let viewModel: HomeViewModel?
    
    //MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addDelegatesAndDataSources()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        
        view.addSubview(genresView)
        genresView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addDelegatesAndDataSources() {
        genresView.collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        genresView.collectionView.dataSource = self
        genresView.collectionView.delegate = self
    }
}

//MARK: - CollectionView
extension GenresVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            if let response = viewModel.genresResponse {
                if let genres = response.data {
                    return genres.count
                }
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else {
            fatalError()
        }
        if let viewModel = viewModel {
            if let response = viewModel.genresResponse {
                if let genres = response.data {
                    cell.updateUI(genresPlaylist: genres[indexPath.item])
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel {
            if let response = viewModel.genresResponse {
                if let genres = response.data {
                    let genre = genres[indexPath.item]
                    
                    if let genreID = genre.id {
                        let genresVC = GenreArtistsVC(genreId: genreID.description, manager: viewModel.manager)
                        genresVC.title = genre.name
                        navigationController?.pushViewController(genresVC, animated: true)
                    }
                }
            }
        }
    }
}

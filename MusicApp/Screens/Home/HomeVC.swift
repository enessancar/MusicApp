//
//  HomeC.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import UIKit
import SnapKit

final class HomeVC: DataLoadingVC {
    
    lazy var homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addDelegataAndDataSource()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureView() {
        title = "Home"
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addDelegataAndDataSource() {
        homeView.discoverCollectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        homeView.genresCollectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        homeView.popularSongsTableView.register(ProfileFavoriteTableViewCell.self, forCellReuseIdentifier: ProfileFavoriteTableViewCell.identifier)
        
        homeView.discoverCollectionView.delegate = self
        homeView.discoverCollectionView.dataSource = self
        
        homeView.popularSongsTableView.delegate = self
        homeView.popularSongsTableView.dataSource = self
        
        homeView.genresCollectionView.delegate = self
        homeView.genresCollectionView.dataSource = self
        
        homeView.browseButton.addTarget(self, action: #selector(browseButtonTapped), for: .touchUpInside)
        
        homeView.exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }
    
    @objc private func browseButtonTapped() {
        let discoverVC = DiscoverVC(viewModel: viewModel)
        navigationController?.pushViewController(discoverVC, animated: true)
    }
    
    @objc private func exploreButtonTapped() {
        let genresVC = GenresVC(viewModel: viewModel)
        navigationController?.pushViewController(genresVC, animated: true)
    }
}


//MARK: - TableView
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let popularSongs = viewModel.popularSongsResponse {
            if let tracks = popularSongs.data {
                return tracks.count
            }
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFavoriteTableViewCell.identifier, for: indexPath) as? ProfileFavoriteTableViewCell else {
            fatalError()
        }
        if let popularSongs = viewModel.popularSongsResponse {
            if let tracks = popularSongs.data {
                cell.updateUI(track: tracks[indexPath.row])
            }
        }
        return cell
    }
}

//MARK: - Collection View DataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.discoverCollectionView:
            return 6
        case homeView.genresCollectionView:
            return 6
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homeView.discoverCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else {
                fatalError()
            }
            if let response = viewModel.radioResponse {
                if let playlists = response.data {
                    let playlist = playlists[indexPath.row]
                    cell.updateUI(playlist: playlist)
                }
            }
            return cell
            
        case homeView.genresCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else {
                fatalError()
            }
            if let response = viewModel.genresResponse {
                if let playlists = response.data {
                    let playlist = playlists[indexPath.row]
                    cell.updateUI(genresPlaylist: playlist)
                }
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - CollectionView Delegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case homeView.discoverCollectionView:
            if let response = viewModel.radioResponse {
                if let playlists = response.data {
                    let playlist = playlists[indexPath.row]
                    
                    if let playlistURL = playlist.tracklist {
                        let playlistVC = playlist
                    }
                }
            }
            
        case homeView.genresCollectionView:
            if let response = viewModel.genresResponse {
                if let genres = response.data {
                    let genre = genres[indexPath.item]
                    
                    if let genresID = genre.id {
                        let genresArtistsVC = GenreArtistsVC(genreId: genresID.description, manager: viewModel.manager)
                        genresArtistsVC.title = genre.name
                        navigationController?.pushViewController(genresArtistsVC, animated: true)
                    }
                }
            }
        default:
            return 
        }
    }
}

//MARK: - HomeViewModelDelegate
extension HomeVC: HomeViewModelDelegate {
    func showProgressView() {
        showLoadingView()
    }
    
    func dismissProgressView() {
        dismissLoadingView()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.homeView.discoverCollectionView.reloadData()
            self.homeView.genresCollectionView.reloadData()
            self.homeView.popularSongsTableView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let response = viewModel.popularSongsResponse {
            if let songs = response.data {
                let song = songs[indexPath.row]
                let vc = PlayerVC(track: song)
                vc.modalPresentationStyle = .pageSheet
                self.present(vc, animated: true)
            }
        }
    }
}

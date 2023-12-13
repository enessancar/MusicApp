//
//  PlaylistVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit
import SnapKit

final class PlaylistVC: UIViewController {
    
    let playlistView = PlaylistView()
    let viewModel: PlaylistViewModel
    
    init(playlistURL: String, deezerAPIManager: DeezerAPIManager) {
        self.viewModel = PlaylistViewModel(playlistURL: playlistURL, deezerAPIManager: deezerAPIManager)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        addDelegatesAndDataSources()
    }
    
    init(userPlaylist: UserPlaylist, firestoreManager: FirestoreManager) {
        self.viewModel = PlaylistViewModel(userplaylist: userPlaylist, firestoreManager: firestoreManager)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        addDelegatesAndDataSources()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playlistView)
        playlistView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addDelegatesAndDataSources() {
        playlistView.tableView.register(ProfileFavoriteTableViewCell.self, forCellReuseIdentifier: ProfileFavoriteTableViewCell.identifier)
        
        playlistView.tableView.dataSource = self
        playlistView.tableView.delegate = self
    }
}

extension PlaylistVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tracks = viewModel.tracks {
            return tracks.count
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = playlistView.tableView.dequeueReusableCell(withIdentifier: ProfileFavoriteTableViewCell.identifier, for: indexPath) as? ProfileFavoriteTableViewCell else {
            fatalError()
        }
        if let tracks = viewModel.tracks {
            let track = tracks[indexPath.row]
            cell.updateUI(track: track)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tracks = viewModel.tracks {
            let track = tracks[indexPath.row]
            
            let vc = PlayerVC(track: track)
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if let userPlaylist = viewModel.userPlaylist {
            let removeTrack = UIContextualAction(style: .destructive,
                                                 title: "Remove") { [weak self] action, view, bool in
                guard let self else { return }
                if let tracks = viewModel.tracks {
                    let track = tracks[indexPath.row]
                    viewModel.removeTrackFromPlaylist(track: track)
                }
            }
            return UISwipeActionsConfiguration(actions: [removeTrack])
        }
        return nil
    }
}

extension PlaylistVC: PlaylistViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.playlistView.tableView.reloadData()
        }
    }
}


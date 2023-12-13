//
//  AddToPlaylistViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import Foundation

protocol AddToPlaylistViewModelDelegate: AnyObject {
    func updateUI()
    func popupDismiss()
}

final class AddToPlaylistViewModel {
    
    var playlists: [UserPlaylist]?
    weak var delegate: AddToPlaylistViewModelDelegate?
    lazy var firestoreManager = FirestoreManager()
    
    init() {
        getUserPlaylists()
    }
    
    func getUserPlaylists() {
            firestoreManager.getUserPlaylists { [weak self] playlists in
                guard let self else { return }
                self.playlists = playlists
                delegate?.updateUI()
            } onError: { error in
                print(error)
            }
        }
    
    func addTrackToPlaylist(track: Track, playlistID: String) {
        firestoreManager.addTrackToPlaylist(track: track, playlistID: playlistID) { [weak self] in
            guard let self else { return }
            delegate?.popupDismiss()
        } onError: { error in
            print(error)
        }
    }
}

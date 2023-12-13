//
//  PlaylistViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit

protocol PlaylistViewModelProtocol: AnyObject {
    func getRadioPlaylist(playlistURL: String)
    var tracks: [Track]? { get set }
}

protocol PlaylistViewModelDelegate: AnyObject {
    func updateUI()
}

final class PlaylistViewModel: PlaylistViewModelProtocol {
    
    var tracks: [Track]?
    var userPlaylist: UserPlaylist?
    var deezerAPIManager: DeezerAPIManager?
    var firestoreManager: FirestoreManager?
    
    weak var delegate: PlaylistViewModelDelegate?
    
    init(playlistURL: String, deezerAPIManager: DeezerAPIManager) {
        self.deezerAPIManager = deezerAPIManager
        getRadioPlaylist(playlistURL: playlistURL)
    }
    
    init(userplaylist: UserPlaylist, firestoreManager: FirestoreManager) {
        self.userPlaylist = userplaylist
        self.firestoreManager = firestoreManager
        getUserPlaylist(playlist: userplaylist)
    }
    
    func getRadioPlaylist(playlistURL: String) {
        deezerAPIManager?.getRadioPlaylist(playlistURL: playlistURL, onSuccess: { data in
            if let tracks = data?.data {
                self.tracks = tracks
            }
            self.delegate?.updateUI()
            
        }, onError: { error in
            print(error)
        })
    }
    
    func getUserPlaylist(playlist: UserPlaylist) {
        firestoreManager?.getUserPlaylist(playlist: playlist, onSuccess: { tracks in
            self.tracks = tracks
            self.delegate?.updateUI()
        }, onError: { error in
            print(error)
        })
    }
    
    func removeTrackFromPlaylist(track: Track) {
        if let userPlaylist {
            firestoreManager?.removeTrackFromPlaylist(
                track: track, userPlaylist: userPlaylist, onSuccess: { [weak self] in
                    guard let self else { return }
                    getUserPlaylist(playlist: userPlaylist)
                }, onError: { error in
                    print(error)
                })
        }
    }
}



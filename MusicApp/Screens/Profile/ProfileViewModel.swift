//
//  ProfileViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func updateUserPhoto(imageURL: URL)
    func updateUsername()
    func updateTableView()
    func dismissCreatePlaylistPopup()
    func showProgressView()
    func dismissProgressView()
}

final class ProfileViewModel {
    
    //MARK: - Variables
    var username: String?
    var playlist: [UserPlaylist]?
    var userFavoriteTracks: [Track]?
    
    weak var delegate: ProfileViewModelDelegate?
    
    lazy var firestoreManager = FirestoreManager()
    lazy var firebaseAuthManager = FirebaseAuthManager()
    lazy var firebaseStorageManager = FirebaseStorageManager()
    
    func getUsername() {
        delegate?.showProgressView()
        firestoreManager.getUserName { [weak self] username in
            guard let self else { return }
            self.username = username
            delegate?.updateUsername()
            delegate?.dismissProgressView()
            
        } onError: { error in
            print(error)
            self.delegate?.dismissProgressView()
        }
    }
    
    func getUserPlaylist() {
        firestoreManager.getUserPlaylists { [weak self] playlists in
            guard let self else { return }
            self.playlist = playlists
            delegate?.updateTableView()
            
        } onError: { error in
            print(error)
        }
    }
    
    func getUserFavoriteTracks() {
        firestoreManager.getUserFavoriteTracks { [weak self] tracks in
            guard let self else { return }
            self.userFavoriteTracks = tracks
            delegate?.updateTableView()
        } onError: { error in
            print(error)
        }
    }
    
    func createNewPlaylist(playlistName: String) {
        firestoreManager.createNewPlaylist(playlistName: playlistName) { [weak self] in
            guard let self else { return }
            getUserPlaylist()
            delegate?.dismissCreatePlaylistPopup()
            
        } onError: { error in
            print(error)
        }
    }
    
    func removeTrackFromFavorites(track: Track) {
        firestoreManager.removeTrackFromFavorites(track: track) { [weak self] in
            guard let self else { return }
            getUserFavoriteTracks()
            delegate?.updateTableView()
    
        } onError: { error in
            print(error)
        }
    }
    
    func removePlaylist(playlist: UserPlaylist) {
        firestoreManager.removePlaylist(playlist: playlist) { [weak self] in
            guard let self else { return }
            getUserPlaylist()
            delegate?.updateTableView()
        } onError: { error in
            print(error)
        }
    }
    
    func uploadUserPhoto(imageData: UIImage) {
        firebaseStorageManager.uploadUserImage(image: imageData) { [weak self] in
            guard let self else { return }
            fetchUserPhoto()
        } onError: { error in
            print(error)
        }
    }
    
    func fetchUserPhoto() {
        delegate?.showProgressView()
        firebaseStorageManager.fetchUserImage() { [weak self] url in
            guard let self else { return }
            delegate?.updateUserPhoto(imageURL: url)
            delegate?.dismissProgressView()
        } onError: { error in
            print(error)
        }
    }
    
    func logout(completion: @escaping () -> ()) {
        firebaseAuthManager.signOut {
            completion()
        } onError: { error in
            print(error)
        }
    }
}

//
//  PlayerViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import AVFoundation

protocol PlayerViewModelDelegate: AnyObject {
    func updateFavorites()
}

protocol PlayerDelegate: AnyObject {
    var currentDuration: CMTime { get set }
    func toggleButtonImage()
}

final class PlayerViewModel {
    
    let track: Track
    var isPlaying = false
    let player: AVPlayer?
    let playerItem: AVPlayerItem?
    var currentDuration: CMTime = .init(seconds: 0, preferredTimescale: 1)
    let firestoreManager = FirestoreManager()
    
    weak var delegate: PlayerViewModelDelegate?
    weak var playerDelegate: PlayerDelegate?
    
    init(track: Track) {
        self.track = track
        
        if let previewURL = track.preview {
            if let url = URL(string: previewURL) {
                self.playerItem = AVPlayerItem(url: url)
                self.player = AVPlayer(playerItem: playerItem)
                self.player?.volume = 0.5
            } else {
                self.playerItem = nil
                self.player = nil
            }
        } else {
            self.playerItem = nil
            self.player = nil
        }
    }
    
    func toggleLikeStatus(completion: @escaping (Bool) -> ()) {
        checkTrackFavorited { [weak self] isFavorited in
            guard let self else { return }
            if isFavorited {
                removeTrackFromFavorites { [weak self] in
                    guard let self else { return }
                    completion(false)
                    delegate?.updateFavorites()
                }
            } else {
                addTrackToFavorites { [weak self] in
                    guard let self else { return }
                    completion(true)
                    delegate?.updateFavorites()
                }
            }
        }
    }
    
    func addTrackToFavorites(completion: @escaping() -> ()) {
        firestoreManager.addTrackToFavorites(track: track) {
            completion()
        } onError: { error in
            print(error)
        }
    }
    
    func removeTrackFromFavorites(completion: @escaping() -> ()) {
        firestoreManager.removeTrackFromFavorites(track: track) {
            completion()
        } onError: { error in
            print(error)
        }
    }
    
    func checkTrackFavorited(completion: @escaping (Bool) -> Void) {
        firestoreManager.checkTrackFavorited(track: track) { [weak self] exists in
            guard let self else { return }
            completion(exists)
        } onError: { error in
            print(error)
        }
    }
    
    func playAudio() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        player?.seek(to: currentDuration)
        player?.play()
        isPlaying = true
        playerDelegate?.toggleButtonImage()
        
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
                                        queue: .main) { [weak self] time in
            guard let self else { return }
            currentDuration = time
            playerDelegate?.currentDuration = time
        }
    }
    
    func pauseAudio() {
        player?.pause()
        isPlaying = false
        playerDelegate?.toggleButtonImage()
    }
    
    func adjustVolume(delta: Float) {
        let newVolume = max(0.0, min((player?.volume ?? 0.0) + delta, 1.0))
        player?.volume = newVolume
    }
    
    //MARK: - @Actions
    @objc func playerDidFinishPlaying(){
        player?.seek(to: CMTime.zero)
        pauseAudio()
    }
}

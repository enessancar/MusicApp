//
//  DeezerAPIManager.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit

final class DeezerAPIManager {
    private let baseURL:String = "https://api.deezer.com/"
    
    func getSearchResults(searchText: String,
                          onSuccess: @escaping(SearchTrackResponse?) -> (),
                          onError: @escaping (String) -> ()) {
        
        AlamofireService.shared.fetch(path: baseURL + Endpoint.search.rawValue + searchText) { (response: SearchTrackResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    func getRadioPlaylists(onSuccess: @escaping (RadioResponse?)->(Void), onError: @escaping (String)->(Void)) {
        AlamofireService.shared.fetch(path: baseURL + Endpoint.radio.rawValue) { (response: RadioResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    func getRadioPlaylist(playlistURL: String,
                          onSuccess: @escaping (RadioPlaylistResponse?) -> (),
                          onError: @escaping (String) -> ()) {
        
        AlamofireService.shared.fetch(path: playlistURL) { (response: RadioPlaylistResponse) in
            
            let filteredTracks = response.data?.filter({ $0.preview != nil || $0.preview != ""})
            var filteredResponse = response
            filteredResponse.data = filteredTracks
            onSuccess(filteredResponse)
            
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    func getGenresLisits(onSuccess: @escaping (GenresMusicResponse?)->(Void), onError: @escaping (String)->(Void)) {
        AlamofireService.shared.fetch(path: baseURL + Endpoint.genre.rawValue) { (response: GenresMusicResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    func getGenresLisitsArtist(id:String, onSuccess: @escaping (GenresArtistListResponse?)->(Void), onError: @escaping (String)->(Void)) {
        AlamofireService.shared.fetch(path: baseURL + "genre/" + id + "/artists" ) { (response: GenresArtistListResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
}

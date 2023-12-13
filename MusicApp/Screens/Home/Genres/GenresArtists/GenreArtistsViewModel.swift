//
//  GenreArtistsViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import Foundation

protocol GenreArtistsViewModelProtocol: AnyObject {
    func getData()
    var data: GenresArtistListResponse? { get set }
}

protocol GenreArtistsViewModelDelegate: AnyObject {
    func updateUI()
}

final class GenreArtistsViewModel: GenreArtistsViewModelProtocol {
    
    let genreId: String
    var data: GenresArtistListResponse?
    let manager: DeezerAPIManager
    weak var delegate: GenreArtistsViewModelDelegate?
    
    init(genreId: String, manager: DeezerAPIManager) {
        self.genreId = genreId
        self.manager = manager
        getData()
    }
    
    func getData() {
        manager.getGenresLisitsArtist(id: genreId) { [weak self] data in
            guard let self else { return }
            self.data = data
            self.delegate?.updateUI()
            
        } onError: { error in
            print(error)
        }
    }
}

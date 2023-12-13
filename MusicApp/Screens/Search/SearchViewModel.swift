//
//  SearchViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import Foundation

protocol ChangeResultsProtocol: AnyObject{
    func changeResults(_ response: SearchTrackResponse)
}

protocol RecentSearchesDelegate: AnyObject {
    func updateRecentSearches()
}

final class SearchViewModel: SearchViewModelProtocol {
    
    var data: SearchTrackResponse?
    weak var changeResultsProtocol: ChangeResultsProtocol?
    weak var recentSearchesDelegate: RecentSearchesDelegate?
    let deezerAPIManager = DeezerAPIManager()
    let firestoreManager = FirestoreManager()
    var searchText = ""
    var recentSearches: [String]?
    
    
    func getData() {
        deezerAPIManager.getSearchResults(searchText: searchText) { [weak self] response in
            guard let self else { return }
            data = response
            if let response {
                self.changeResultsProtocol?.changeResults(response)
            }
        } onError: { error in
            print(error)
        }
    }
    
    func getRecentSearch() {
        firestoreManager.getRecentSearches { [weak self] recentSearches in
            guard let self else { return }
            self.recentSearches = recentSearches
            recentSearchesDelegate?.updateRecentSearches()
            
        } onError: { error in
            print(error)
        }
    }
    
    func updateRecentSearches(searchText: String) {
        firestoreManager.updateRecentSearches(searchText: searchText) { [weak self] in
            guard let self else { return }
            getRecentSearch()
            
        } onError: { error in
            print(error)
        }
    }
    
    func clearRecentSearches() {
        firestoreManager.clearRecentSearches { [weak self] in
            guard let self else { return }
            getRecentSearch()
            
        } onError: { error in
            print(error)
        }
    }
}

//
//  SearchVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import UIKit
import SnapKit

final class SearchVC: UIViewController {
    
    private lazy var recentSearchesView = RecentSearchesView()
    private lazy var viewModel = SearchViewModel()
    private lazy var workItem = WorkItem()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultVC(viewModel: viewModel))
        
        searchController.searchBar.placeholder = "Search for songs, albums, or artists"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        addDelegatesAndDataSources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getRecentSearch()
    }
    
    private func configureView() {
        view.addSubview(recentSearchesView)
        recentSearchesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        recentSearchesView.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Song Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func addDelegatesAndDataSources() {
        viewModel.recentSearchesDelegate = self
        recentSearchesView.recentSearchesTableView.dataSource = self
        recentSearchesView.recentSearchesTableView.delegate = self
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recentSearches = viewModel.recentSearches {
            return recentSearches.count
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let recentSearches = viewModel.recentSearches {
            let searchText = recentSearches[indexPath.row]
            cell.textLabel?.text = searchText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let recentSearches = viewModel.recentSearches {
            let searchText = recentSearches[indexPath.row]
            searchController.searchBar.text = searchText
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension SearchVC: RecentSearchesDelegate {
    func updateRecentSearches() {
        DispatchQueue.main.async {
            self.recentSearchesView.recentSearchesTableView.reloadData()
        }
    }
}

extension SearchVC: RecentSearchesViewDelegate {
    func recentSearchButtonTapped() {
        viewModel.clearRecentSearches()
    }
}

extension SearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        
        if query == "" {
            let resultVC = searchController.searchResultsController as! SearchResultVC
            viewModel.data = nil
            resultVC.searchResultView.searchResultTableView.reloadData()
        } else {
            workItem.perform(after: 0.5) { [weak self] in
                guard let self else { return }
                viewModel.searchText = query
                viewModel.getData()
                viewModel.updateRecentSearches(searchText: query)
            }
        }
    }
}

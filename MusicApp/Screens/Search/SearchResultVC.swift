//
//  SearchResultVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 12.12.2023.
//

import UIKit
import SnapKit 
import AVFoundation

protocol SearchViewModelProtocol: AnyObject {
    func getData()
    var data: SearchTrackResponse? { get set }
}

final class SearchResultVC: UIViewController {
    
    lazy var searchResultView = SearchResultView()
    private let viewModel: SearchViewModel
    weak var viewModelDelegate: SearchViewModelProtocol?
    
    var player: AVPlayer?
    var isPlaying = false
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addDelegatesAndDataSources()
    }
    
    private func configureView() {
        view.addSubview(searchResultView)
        searchResultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addDelegatesAndDataSources() {
        searchResultView.searchResultTableView.register(
            ProfileFavoriteTableViewCell.self,
            forCellReuseIdentifier: ProfileFavoriteTableViewCell.identifier)
        
        searchResultView.searchResultTableView.delegate = self
        searchResultView.searchResultTableView.dataSource = self
        
        viewModel.changeResultsProtocol = self
        viewModelDelegate = viewModel
    }
    
    func playAudio(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        player?.play()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        
    }
}

//MARK: - Table View
extension SearchResultVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = viewModel.data {
            if let songs = response.data {
                return songs.count
            }
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultView.searchResultTableView.dequeueReusableCell(withIdentifier: ProfileFavoriteTableViewCell.identifier) as? ProfileFavoriteTableViewCell else {
            fatalError()
        }
        if let response = viewModel.data {
            if let data = response.data {
                cell.updateUI(track: data[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let response = viewModel.data {
            if let data = response.data {
                let song = data[indexPath.row]
                
                let vc = PlayerVC(track: song)
                vc.modalPresentationStyle = .pageSheet
                self.present(vc, animated: true)
            }
        }
    }
}

extension SearchResultVC: ChangeResultsProtocol {
    func changeResults(_ response: SearchTrackResponse) {
        DispatchQueue.main.async {
            self.searchResultView.searchResultTableView.reloadData()
        }
    }
}

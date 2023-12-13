//
//  AddToPlaylistPopupVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 9.12.2023.
//

import UIKit
import SnapKit

final class AddToPlaylistPopupVC: UIViewController {
    
    // MARK: - Properties
    lazy var viewModel = AddToPlaylistViewModel()
    lazy var containerView  = AlertContainerView()
    var track: Track?
    
    //MARK: - UI Elements
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: FontSize.subHeadline)
        label.text = "Choose Playlist"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var cancelButton: MusicButton = {
        let button = MusicButton(bgColor: .systemPink, color: .systemPink, title: "Cancel", systemImageName: "x.circle")
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    init(tack: Track) {
        self.track = tack
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(ProfilePlaylistTableViewCell.self, forCellReuseIdentifier: ProfilePlaylistTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserPlaylists()
    }
    
    
    //MARK: - Configuration Methods
    private func configureUI() {
        configureContainerView()
        configureTitleLabel()
        configureCancelButton()
        configureTableView()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(320)
        }
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.height.equalTo(28)
        }
    }
    
    private func configureCancelButton() {
        containerView.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
        }
    }
    
    private func configureTableView() {
        containerView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(cancelButton.snp.top).offset(-10)
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension AddToPlaylistPopupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playlists = viewModel.playlists {
            return playlists.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePlaylistTableViewCell.identifier, for: indexPath) as? ProfilePlaylistTableViewCell else {
            fatalError()
        }
        if let userPlaylists = viewModel.playlists {
            let userPlaylist = userPlaylists[indexPath.row]
            cell.updateUI(userPlaylist: userPlaylist)
        }
        return cell
    }
}

extension AddToPlaylistPopupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let playlists = viewModel.playlists {
            let playlist = playlists[indexPath.row]
            
            if let title = playlist.title {
                viewModel.addTrackToPlaylist(track: track!, playlistID: title)
            }
        }
        
    }
}

extension AddToPlaylistPopupVC: AddToPlaylistViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func popupDismiss() {
        dismissVC()
    }
}

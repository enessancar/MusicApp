//
//  CreatePlaylistPopupVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import UIKit
import SnapKit

final class CreatePlaylistPopupVC: UIViewController {
    
    private let createPlaylistView = CreatePlaylistView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(createPlaylistView)
        
        createPlaylistView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        createPlaylistView.delegate = self
    }
}

extension CreatePlaylistPopupVC: CreatePlaylistViewDelegate {
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

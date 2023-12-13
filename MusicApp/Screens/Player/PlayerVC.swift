//
//  PlayerVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import UIKit
import SnapKit

final class PlayerVC: UIViewController {
    
    private let playerView = PlayerView()
    var viewModel: PlayerViewModel?
    
    init(track: Track) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

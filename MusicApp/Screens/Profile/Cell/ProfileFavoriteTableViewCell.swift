//
//  ProfileFavoriteTableViewCell.swift
//  MusicApp
//
//  Created by Enes Sancar on 5.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class ProfileFavoriteTableViewCell: UITableViewCell {
    static let identifier = "ProfileFavoriteTableViewCell"
    
    //MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var artistAndSongNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            artistAndSongNameLabel,
            albumNameLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: SFSymbols.play), for: .normal)
        button.tintColor = .label
        button.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            songImageView,
            vStackView,
            playButton
        ])
        stackView.setCustomSpacing(15, after: songImageView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        selectionStyle = .none
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func updateUI(track: Track) {
        if let album = track.album {
            songImageView.kf.setImage(with: album._coverXL.asUrl)
        }
        albumNameLabel.text = track._title
        
        if let artist = track.artist,
           let songName = track.title {
            if let artistName = artist.name {
                artistAndSongNameLabel.text = "\(artistName) - \(songName)"
            }
        }
    }
}

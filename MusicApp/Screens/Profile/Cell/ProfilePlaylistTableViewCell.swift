//
//  ProfileTableViewCell.swift
//  MusicApp
//
//  Created by Enes Sancar on 5.12.2023.
//

import UIKit
import SnapKit

final class ProfilePlaylistTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    //MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playlistNameLabel, trackCountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var containerHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playlistImageView, textVStackView])
        stackView.setCustomSpacing(15, after: playlistImageView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        imageView.image = UIImage(systemName: SFSymbols.music)
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var playlistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var trackCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
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
        accessoryType = .disclosureIndicator
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(containerHStackView)
        containerHStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func updateUI(userPlaylist: UserPlaylist) {
        playlistNameLabel.text = userPlaylist._title
        trackCountLabel.text = "\(userPlaylist._trackCount) Tracks"
    }
}

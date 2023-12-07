//
//  ProfileView.swift
//  MusicApp
//
//  Created by Enes Sancar on 5.12.2023.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    
    //MARK: - Properties
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            userImage,
            userName,
            buttonStack
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var userImage : UIImageView = {
        let image = UIImageView()
        let blankProfileImage = UIImage(systemName: SFSymbols.person)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.image = blankProfileImage
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    lazy var userName: UILabel = {
        let userName = UILabel()
        userName.text = " "
        userName.font = UIFont.systemFont(ofSize: FontSize.subHeadline)
        userName.textColor = .label
        return userName
    }()
    
    lazy var editButton: UIButton = {
        let editButton = UIButton(configuration: .bordered())
        editButton.configuration?.cornerStyle = .capsule
        editButton.setTitle("Edit", for: .normal)
        editButton.tintColor = .label
        return editButton
    }()
    
    lazy var logoutButton: UIButton = {
        let editButton = UIButton(configuration: .tinted())
        editButton.configuration?.cornerStyle = .capsule
        editButton.setTitle("Logout", for: .normal)
        editButton.configuration?.baseBackgroundColor = .systemRed
        editButton.configuration?.baseForegroundColor = .systemRed
        return editButton
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [editButton,
                                                   logoutButton])
        stack.spacing = 8
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Playlists", at: 0, animated: true)
        segment.insertSegment(withTitle: "Favorites", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ProfilePlaylistTableViewCell.self, forCellReuseIdentifier: ProfilePlaylistTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var createPlaylistButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.configuration?.cornerStyle = .capsule
        button.setImage(UIImage(systemName: SFSymbols.plus), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.tintColor = .label
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeaderStackView()
        configureSegmentedControl()
        configurePlaylistTableView()
        configureCreatePlaylistButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(180)
        }
        
        editButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(45)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeaderStackView() {
        addSubview(headerStackView)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureSegmentedControl() {
        addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func configurePlaylistTableView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureCreatePlaylistButton() {
        addSubview(createPlaylistButton)
        
        createPlaylistButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
    }
}

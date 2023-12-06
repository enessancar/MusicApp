//
//  PlayerView.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import UIKit
import SnapKit
import MediaPlayer

final class PlayerView: UIView {
    
    //MARK: - Properties
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            songImage,
            textAndIconContainer,
            sliderVStack,
            playerControlHStack,
            sliderVolumeHStack
        ])
        
        stackView.setCustomSpacing(25, after: textAndIconContainer)
        stackView.setCustomSpacing(25, after: sliderVStack)
        stackView.setCustomSpacing(25, after: playerControlHStack)
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var songImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.PlayerView.noSong)
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
        return image
    }()
    
    private lazy var textAndIconContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textVStack, iconStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var textVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [songTitle, artistName])
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            addToPlaylistButton,
            likeButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var addToPlaylistButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.PlayerView.addToPlaylist), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.PlayerView.heart), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var songTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.subHeadline)
        label.textColor = .label
        return label
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.subHeadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var sliderVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            songSlider, timeHStack
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var songSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = .zero
        slider.maximumValue = 30
        slider.value = 0
        return slider
    }()
    
    private lazy var timeHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            timeLabelMin,
            timeLabelMax
        ])
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var timeLabelMin: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        return label
    }()
    
    lazy var timeLabelMax: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var playerControlHStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            rewindButton, playButton, fastForwardButton,
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: Constants.PlayerView.rewind)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: Constants.PlayerView.play)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var fastForwardButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: Constants.PlayerView.forward)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private lazy var sliderVolumeHStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            volumeDownButton, volumeSlider, volumeUpButton
        ])
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var volumeDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.PlayerView.volumeDown), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var volumeUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.PlayerView.volumeUp), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = .zero
        slider.maximumValue = 10
        slider.value = 5
        return slider
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

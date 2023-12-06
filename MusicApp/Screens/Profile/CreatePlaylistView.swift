//
//  CreatePlaylistView.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import UIKit
import SnapKit

protocol CreatePlaylistViewDelegate {
    func cancelButtonTapped()
}

final class CreatePlaylistView: UIView {
    
    //MARK: - Properties
    lazy var containerView = AlertContainerView()
    var delegate: CreatePlaylistViewDelegate?
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 20)
        label.text = Constants.CreatePlaylistView.title
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.CreatePlaylistView.textField
        return textField
    }()
    
    lazy var createButton: MusicButton = {
        let button = MusicButton(bgColor: .systemPink, color: .systemPink, title: Constants.CreatePlaylistView.create, systemImageName: SFSymbols.createButton)
        return button
    }()
    
    private lazy var cancelButton: MusicButton = {
        let button = MusicButton(bgColor: .systemPink, color: .systemPink, title: Constants.CreatePlaylistView.cancel, systemImageName: SFSymbols.cancelButton)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            createButton,
            cancelButton
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureTextField()
        configureButtonStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(220)
        }
    }
    
    private func configureTitleLabel() {
        containerView.addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.height.equalTo(28)
        }
    }
    
    private func configureTextField() {
        containerView.addSubviews(textField)
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    
    private func configureButtonStackView() {
        containerView.addSubviews(buttonsStackView)
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(textField)
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
        }
    }
}

extension CreatePlaylistView {
    @objc private func dismissVC() {
        delegate?.cancelButtonTapped()
    }
}

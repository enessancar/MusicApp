//
//  ForgotPasswordView.swift
//  MusicApp
//
//  Created by Enes Sancar on 2.12.2023.
//

import UIKit
import SnapKit

protocol ForgotPasswordViewDelegate {
    func forgotPasswordButtonTapped()
    func signInButtonTapped()
}

final class ForgotPasswordView: UIView {
    
    var delegate: ForgotPasswordViewDelegate?
    
    private lazy var headLabel = TitleLabel(textAlignment: .left, fontSize: FontSize.subHeadline)
    
    private lazy var emailTextField = CustomTextField(fieldType: .email)
    private let infoLabel = SecondaryTitleLabel(fontSize: FontSize.body)
    private let stackView = UIStackView()
    
    private lazy var sumbitButton = MusicButton(
        bgColor: .authButtonBackground,
        color: .authButtonBackground,
        title: Constants.ForgotPasswordView.sumbit)
    
    private lazy var signInButton = MusicButton(
        bgColor: .authButtonBackground,
        color: .authButtonBackground,
        title: Constants.LoginView.signIn)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        addSubview(headLabel)
        
        headLabel.text = Constants.ForgotPasswordView.headLabel
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func configureEmailTextField() {
        addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func configureSumbitButton() {
        addSubview(sumbitButton)
        
        sumbitButton.configuration?.cornerStyle = .capsule
        sumbitButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        sumbitButton.addTarget(self, action: #selector(didTapSumbitButton), for: .touchUpInside)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = Constants.ForgotPasswordView.infoLabel
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(sumbitButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
}

extension ForgotPasswordView {
    @objc private func didTapSumbitButton() {
        delegate?.forgotPasswordButtonTapped()
    }
    
    @objc private func didTapSignIn() {
        delegate?.signInButtonTapped()
    }
}

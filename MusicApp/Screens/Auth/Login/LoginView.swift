//
//  LoginView.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseAuth
 
protocol LoginViewDelegate {
    func forgotPasswordButtonTapped()
    func signInButtonTapped()
    func googleSignInButtonTapped()
    func newUserButtonTapped()
}

final class LoginView: UIView {
    
    var delegate: LoginViewDelegate?
    
    //MARK: - Properties
    private let headLabel = TitleLabel(textAlignment: .left, fontSize: FontSize.subHeadline)
    
    lazy var emailTextField = CustomTextField(fieldType: .email)
    lazy var passwordTextField = CustomTextField(fieldType: .password)
    private let infoLabel = SecondaryTitleLabel(fontSize: FontSize.body)
    
    private lazy var signInButton = MusicButton(
        bgColor: .authButtonBackground ,
        color: .authButtonBackground ,
        title: Constants.LoginView.signIn,
        fontSize: .big)
    
    private lazy var googleSignInButton = MusicButton(
        bgColor: UIColor.systemBlue ,
        color: UIColor.systemBlue,
        title: Constants.LoginView.googleTitle,
        fontSize: .big,
        systemImageName: Constants.LoginView.googleImage)
    
    private lazy var newUserButton = MusicButton(
        bgColor:.clear ,
        color: .label,
        title: Constants.LoginView.signUp,
        fontSize: .small)
    
    private lazy var forgotPasswordButton = MusicButton(
        bgColor:.clear ,
        color: .authButtonBackground ,
        title: Constants.LoginView.forgotPassword,
        fontSize: .small)
    
    private let viewModel = AuthViewModel()
    private let stackView = UIStackView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeadLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureForgotPasswordButton()
        configureSignInButton()
        configureGoogleSignInButton()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        addSubview(headLabel)
        headLabel.text = Constants.LoginView.headLabel
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
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
    
    private func configurePasswordTextField() {
        addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
    }
    
    private func configureForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        forgotPasswordButton.addTarget(self,
                                       action: #selector(didTapForgotPassword),
                                       for: .touchUpInside)
    }
    
    private func configureSignInButton() {
        addSubview(signInButton)
        signInButton.configuration?.cornerStyle = .capsule
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    private func configureGoogleSignInButton() {
        addSubview(googleSignInButton)
        googleSignInButton.configuration?.cornerStyle = .capsule
        
        googleSignInButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(signInButton)
        }
        googleSignInButton.addTarget(self, action: #selector(didTapGoogleSignIn), for: .touchUpInside)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(newUserButton)
        
        infoLabel.text = Constants.LoginView.infoLabel
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(googleSignInButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
    }
}

extension LoginView {
    @objc private func didTapForgotPassword() {
        delegate?.forgotPasswordButtonTapped()
    }
    
    @objc private func didTapSignIn() {
        delegate?.signInButtonTapped()
    }
    
    @objc private func didTapGoogleSignIn() {
        delegate?.googleSignInButtonTapped()
    }
    
    @objc private func didTapNewUser() {
        delegate?.newUserButtonTapped()
    }
}

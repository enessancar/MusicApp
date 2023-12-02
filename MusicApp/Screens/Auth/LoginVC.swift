//
//  LoginVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)
        loginView.delegate = self
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension LoginVC: LoginViewDelegate {
    
    func signInButtonTapped() {
        <#code#>
    }
    
    func googleSignInButtonTapped() {
        <#code#>
    }
    
    func forgotPasswordButtonTapped() {
        let vc = ForgotPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func newUserButtonTapped() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

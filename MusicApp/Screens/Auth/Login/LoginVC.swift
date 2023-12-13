//
//  LoginVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn

final class LoginVC: UIViewController {
    
    private let loginView = LoginView()
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.delegate = self
    }
}

extension LoginVC: LoginViewDelegate {
    
    func signInButtonTapped() {
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else {
            presentAlert(title: "Error!", message: "Email / Password ? ", buttonTitle: "Ok")
            return
        }
        
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Error!", message: "Email in invalid form ", buttonTitle: "Ok")
            return
        }
        
        guard password.isValidPassword(password: password) else {
            
            guard password.count >= 6 else {
                presentAlert(title: "Error!", message: "Password must be least 6 characters", buttonTitle: "Ok")
                return
            }
            guard password.containsDigits(password) else {
                presentAlert(title: "Error!", message: "Password must be contain at least 1 digits", buttonTitle: "Ok")
                return
            }
            guard password.containsLowerCase(password) else {
                presentAlert(title: "Error", message: "Password must be contain at least 1 lowercase character", buttonTitle: "Ok")
                return
            }
            guard password.containsUpperCase(password) else {
                presentAlert(title: "Error", message: "Password must be contain at least 1 uppercase character", buttonTitle: "Ok")
                return
            }
            return
        }
        authViewModel.login(email: email, password: password) { [weak self] in
            guard let self else { return }
            presentAlert(title: "Alert", message: "Entry succesfully", buttonTitle: "Ok")
            let mainTabbar = MainTabBarVC()
            self.view.window?.rootViewController = mainTabbar
        }
    }
    
    func googleSignInButtonTapped() {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString,
                  let username = user.profile?.name else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            authViewModel.signInGoogle(credential: credential, username: username) {
                [weak self] in
                guard let self else { return }
                presentAlert(title: "Alert!", message: "Registration succesfull", buttonTitle: "Ok")
                let mainTabbar = MainTabBarVC()
                self.view.window?.rootViewController = mainTabbar
            }
        }
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

//
//  ForgotPasswordVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit
import SnapKit

final class ForgotPasswordVC: UIViewController {
    
    private let forgotPasswordView = ForgotPasswordView()
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(forgotPasswordView)
        forgotPasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        forgotPasswordView.delegate = self
    }
}

extension ForgotPasswordVC: ForgotPasswordViewDelegate {
    func forgotPasswordButtonTapped() {
        guard let email = forgotPasswordView.emailTextField.text else {
            return
        }
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Invalid Email Adress", buttonTitle: "Ok")
            return
        }
        viewModel.resetPassword(email: email) { [weak self] success, message in
            guard let self else { return }
            
            if success {
                presentAlert(title: "Alert", message: message, buttonTitle: "Ok")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                presentAlert(title: "Error!", message: message, buttonTitle: "Ok")
            }
        }
    }
    
    func signInButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

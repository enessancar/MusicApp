//
//  AuthViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit
import FirebaseAuth 

final class AuthViewModel {
    
    lazy var authManager = FirebaseAuthManager()
    
    func login(email: String, password: String, completion: @escaping () -> Void){
        authManager.signIn(email: email, password: password) {
            completion()
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    func register(userName: String, email: String, password: String, completion: @escaping () -> Void) {
        authManager.register(userName: userName,
                             email: email,
                             password: password) {
            completion()
        } onError: { error in
            print(error)
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        guard !email.isEmpty else {
            completion(false, "E-mail cannot be blank.")
            return
        }
        
        authManager.resetPassword(email: email) { [weak self] in
            guard let self else { return }
            
            completion(true, "Please check your e-mail to reset your password.")
            
        } onError: { [weak self] error in
            guard let self else { return }
            completion(false, error)
        }
    }
    
    func signInGoogle(credential: AuthCredential, username: String, completion: @escaping () -> Void) {
        authManager.signInWithCredential(credential: credential, username: username) {
            completion()
        } onError: { error in
            print(error)
        }
    }
}

//
//  SceneDelegate.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // MARK: - onboardingVC
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if !hasLaunchedBefore {
            let onboardingVC = OnboardingVC()
            onboardingVC.modalPresentationStyle = .fullScreen
            window?.rootViewController = onboardingVC
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        } else {
            let loginVC = LoginVC()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            window?.rootViewController = nav
        }
        
        
        if ApplicationVariables.currentUserID != nil {
            let TabBar = MainTabBarVC()
            TabBar.modalPresentationStyle = .fullScreen
            window?.rootViewController = TabBar
        }
        self.window?.makeKeyAndVisible()
    }
}



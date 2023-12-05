//
//  MainTabBarVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import UIKit

final class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
        configureTabBar()
        configureNavigationBar()
    }
    
    private func configureVC() {
        viewControllers = [
            createNavController(for: HomeVC(), title: "Home", imageName: "house"),
            createNavController(for: SearchVC(), title: "Search", imageName: "magnifyingglass"),
            createNavController(for: ProfileVC(), title: "Profile", imageName: "person")
        ]
    }
    
    fileprivate func createNavController(for viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .systemBackground
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
    
    private func configureTabBar() {
        UITabBar.appearance().tintColor = .label
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        } else {
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
    }
    
    private func configureNavigationBar() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}


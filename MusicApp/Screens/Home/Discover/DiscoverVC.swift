//
//  DiscoverVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit

final class DiscoverVC: UIViewController {
    
    lazy var discoverView = DiscoverView()
    let viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addDelegatesAndDataSources()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addDelegatesAndDataSources() {
        
    }
}

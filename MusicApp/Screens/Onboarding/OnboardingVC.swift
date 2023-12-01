//
//  OnboardingVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit

final class OnboardingVC: UIViewController {
    
    private let viewModel = OnboardingViewModel()
    private let onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        onboardingView.collectionView.delegate = self
        onboardingView.collectionView.dataSource = self
        
        onboardingView.delegate = self
    }
}


//MARK: - CollectionView
extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        onboardingView.sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as? SliderCollectionViewCell else {
            fatalError()
        }
        let sliderData = onboardingView.sliderData[indexPath.item]
        cell.updateUI(sliderData: sliderData)
        return cell
    }
}

extension OnboardingVC: OnboardingViewDelegate {
    func skipButtonTapped() {
        <#code#>
    }
    
    func nextSlideButtonTapped() {
        <#code#>
    }
}

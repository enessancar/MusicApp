//
//  OnboardingVC.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit
import SnapKit

final class OnboardingVC: UIViewController {
    
    private let viewModel = OnboardingViewModel()
    private let onboardingView = OnboardingView()
    
    private var fromValue: CGFloat = 0
    private let shape = CAShapeLayer()
    private var currentPageIndex: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardView()
    }
    
    private func setupOnboardView() {
        view.addSubview(onboardingView)
        onboardingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        onboardingView.currentSlide = indexPath.item
        
        onboardingView.pages.forEach { page in
            let tag = page.tag
            
            page.constraints.forEach { conts in
                page.removeConstraint(conts)
            }
            
            let viewTag = indexPath.row + 1
            
            if viewTag == tag{
                page.layer.opacity = 1
                page.snp.makeConstraints { make in
                    make.width.equalTo(20)
                }
                
            } else {
                page.layer.opacity = 0.5
                page.snp.makeConstraints { make in
                    make.width.equalTo(10)
                }
            }
            page.snp.makeConstraints { make in
                make.height.equalTo(10)
            }
            
            
        }
        
        let curentIndex = onboardingView.currentPageIndex * CGFloat(indexPath.item+1)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = curentIndex
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 0.5
        shape.add(animation, forKey: "animation")
        
        fromValue = curentIndex
    }
}

extension OnboardingVC: OnboardingViewDelegate {
    func skipButtonTapped() {
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func nextSlideButtonTapped() {
        let maxSlider = onboardingView.sliderData.count
        if onboardingView.currentSlide < maxSlider - 1 {
            onboardingView.currentSlide += 1
            onboardingView.collectionView.scrollToItem(
                at: IndexPath(item: onboardingView.currentSlide,
                              section: .zero),
                at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollToSlideTapped(sender: UIGestureRecognizer) {
        if let index = sender.view?.tag{
            onboardingView.collectionView.scrollToItem(at: IndexPath(item: index-1, section: 0), at: .centeredHorizontally, animated: true)
            
            onboardingView.currentSlide = index - 1
        }
    }
}


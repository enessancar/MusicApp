//
//  SliderCell.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit
import Lottie
import SnapKit

final class SliderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SliderCollectionViewCell"
    
    //MARK: - UI Elements
    private lazy var lottieView: LottieAnimationView = {
        let lottieView = LottieAnimationView()
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        return lottieView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .authButtonBackground
        label.font = .systemFont(ofSize: FontSize.subHeadline, weight: .black)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLottieView()
        configureTitleLabel()
        configureTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureLottieView() {
        contentView.addSubview(lottieView)
        
        lottieView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lottieView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureTextLabel() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    
    public func animationSetup(name: String) {
        lottieView.animation = LottieAnimation.named(name)
        lottieView.play()
    }
    
    public func updateUI(sliderData: OnboardingItemModel) {
        contentView.backgroundColor = sliderData.color
        titleLabel.text = sliderData.title
        textLabel.text = sliderData.text
        animationSetup(name: sliderData.animationName)
    }
}

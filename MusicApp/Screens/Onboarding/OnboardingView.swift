//
//  OnboardingView.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit
import SnapKit

protocol OnboardingViewDelegate {
    func skipButtonTapped()
    func nextSlideButtonTapped()
}

final class OnboardingView: UIView {
    
    var delegate: OnboardingViewDelegate?
    
    private let viewModel = OnboardingViewModel()
    var sliderData: [OnboardingItemModel] = []
    
    //MARK: - UI Elements
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: frame.width, height: frame.height)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        collection.isPagingEnabled = true
        return collection
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Onboarding.skip, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.body)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let shape = CAShapeLayer()
    private var currentPageIndex: CGFloat = .zero
    private var fromValue: CGFloat = .zero
    
    private var pages: [UIView] = []
    private var currentSlide = 0
    
    private lazy var nextButton: UIView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNextSlide))
        
        let nextImage = UIImageView()
        nextImage.image = UIImage(systemName: Constants.Onboarding.nextButtonImage)
        nextImage.tintColor = .white
        nextImage.contentMode = .scaleAspectFit

        nextImage.snp.makeConstraints { make in
            make.width.height.equalTo(55)
            make.center.equalToSuperview()
        }
        
        let button = UIView()
        button.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        button.addSubview(nextImage)
        
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        sliderData = viewModel.sliderData
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupShape() {
        currentPageIndex = CGFloat(1) / CGFloat(sliderData.count)
        
        let nextStroke = UIBezierPath(arcCenter: CGPoint(x: 30, y: 30), radius: 31, startAngle: -(.pi/2), endAngle: 5, clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = nextStroke.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 4
        trackShape.strokeColor = UIColor.white.cgColor
        trackShape.opacity = 0.1
        nextButton.layer.addSublayer(trackShape)
        
        shape.path = nextStroke.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 4
        shape.lineCap = .round
        shape.strokeStart = 0
        shape.strokeEnd = 0
        
        nextButton.layer.addSublayer(shape)
    }
    
    private func setupControl() {
        addSubview(containerStackView)
        addSubview(skipButton)
        
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill
        
        for tag in 1...sliderData.count{
            let pager = UIView()
            pager.tag = tag
            pager.backgroundColor = .white
            pager.layer.cornerRadius = 5
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            self.pages.append(pager)
            pagerStack.addArrangedSubview(pager)
            
        }
        
        containerStackView.addArrangedSubview(nextButton)
        containerStackView.addArrangedSubview(pagerStack)
        
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension OnboardingView {
    @objc private func didTapSkipButton() {
        delegate?.skipButtonTapped()
    }
    
    @objc private func didTapNextSlide() {
        delegate?.nextSlideButtonTapped()
    }
}


//
//  SliderCell.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit
import Lottie

final class SliderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SliderCollectionViewCell"
    
    //MARK: - UI Elements
    private lazy var lottieView: LottieAnimationView = {
        let lottieView = LottieAnimationView()
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        return lottieView
    }()
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

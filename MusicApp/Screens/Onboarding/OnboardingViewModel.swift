//
//  OnboardingViewModel.swift
//  MusicApp
//
//  Created by Enes Sancar on 30.11.2023.
//

import UIKit

final class OnboardingViewModel {
    
    let sliderData: [OnboardingItemModel] = [
        .init(color: Constants.OnboardPageOne.color ,
              title: Constants.OnboardPageOne.title,
              text: Constants.OnboardPageOne.text,
              animationName: Constants.OnboardPageOne.animationName),
        
            .init(color: Constants.OnboardPageTwo.color ,
                  title: Constants.OnboardPageTwo.title,
                  text: Constants.OnboardPageTwo.text,
                  animationName: Constants.OnboardPageTwo.animationName),
        
            .init(color: Constants.OnboardPageThree.color ,
                  title: Constants.OnboardPageThree.title,
                  text: Constants.OnboardPageThree.text,
                  animationName: Constants.OnboardPageThree.animationName),
    ]
}

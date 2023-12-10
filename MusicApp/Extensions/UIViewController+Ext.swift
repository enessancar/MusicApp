//
//  UIViewController+Ext.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func presentDefualtError() {
        let alertVC = AlertVC(title: "Something Wnt Wrong !",
                              message: "We were unable to complete your task at this time . Please try again.",
                              buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
    }
}

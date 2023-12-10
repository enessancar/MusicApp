//
//  Int+Ext.swift
//  MusicApp
//
//  Created by Enes Sancar on 6.12.2023.
//

import Foundation
 
extension Int {
    func formatTime() -> String {
        let minutes = self / 60
        let remainingSeconds = self % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

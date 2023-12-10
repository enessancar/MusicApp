//
//  UserPlaylist.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import Foundation

struct UserPlaylist: Codable {
    let image: String?
    let title: String?
    let trackCount: Int?
    let tracks: [Track]?
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _trackCount: Int {
        trackCount ?? .zero
    }
}

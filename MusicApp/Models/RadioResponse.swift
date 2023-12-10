//
//  RadioResponse.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import Foundation

struct RadioResponse: Codable {
    let data: [Playlist]?
}

// MARK: - Playlist
struct Playlist: Codable {
    let id: Int
    let title: String?
    let picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let tracklist: String?
    let md5Image: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, title, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist
        case md5Image = "md5_image"
        case type
    }
    
    var _pictureXL: String {
        pictureXl ?? "N/A"
    }
    
    var _title: String {
        title ?? "N/A"
        
    }
}

struct RadioPlaylistResponse: Codable {
    var data: [Track]?
}

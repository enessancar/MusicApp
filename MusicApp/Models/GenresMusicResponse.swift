//
//  GenresMusicResponse.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import Foundation

struct GenresMusicResponse: Codable {
    let data: [GenresPlayList]?
}

// MARK: - Datum
struct GenresPlayList: Codable {
    let id: Int?
    let name: String?
    let picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case type
    }
    
    var _pictureXL: String {
        pictureXl ?? "N/A"
    }
    
    var _name: String {
        name ?? "N/A"
    }
}

struct GenresArtistListResponse: Codable {
    let data: [Artist]? 
}

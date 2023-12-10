//
//  SearchTrackResponse.swift
//  MusicApp
//
//  Created by Enes Sancar on 4.12.2023.
//

import Foundation

struct SearchTrackResponse: Codable {
    let data: [Track]?
    let total: Int?
}

// MARK: - Track
struct Track: Codable {
    let id: Int?
    let readable: Bool?
    let title, titleShort: String?
    let link: String?
    let duration: Int?
    let rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let artist: Artist?
    let album: Album?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, album, type
    }
    
    var _title: String {
        title ?? "N/A"
    }
}

// MARK: - Album
struct Album: Codable {
    let id: Int?
    let title: String?
    let cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let tracklist: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
    
    var _coverXL: String {
        coverXl ?? "N/A"
    }
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int?
    let name: String?
    let link, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let tracklist: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist, type
    }
    
    var _pictureXL: String {
        pictureXl ?? "N/A"
    }
    
    var _name: String {
        name ?? "N/A"
    }
}

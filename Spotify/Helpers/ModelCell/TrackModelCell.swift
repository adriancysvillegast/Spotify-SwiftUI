//
//  TrackModelCell.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/11/23.
//

import Foundation

struct TrackModelCell {
    var album: AlbumResponse?
    let artists: String
//    let availableMarkets: [String]
//    let discNumber: Int
//    let durationMs: Int
    let explicit: Bool
//    let externalUrls: [String: String]
    let id: String
    let name: String
    let previewUrl: URL?
}

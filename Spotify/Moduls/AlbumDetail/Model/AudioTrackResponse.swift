//
//  AudioTrackResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import Foundation
import SwiftUI

struct AudioTrackResponse: Codable {
    var album: AlbumResponse?
    let artists: [ArtistsResponse]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: [String: String]
    let id: String
    let name: String
    let previewUrl: String?
}

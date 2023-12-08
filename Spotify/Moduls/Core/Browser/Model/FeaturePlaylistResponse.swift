//
//  FeaturePlaylistResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/12/23.
//

import Foundation
import SwiftUI

struct FeaturePlaylistResponse: Codable {
    let playlists: PlaylistsResponse
}

struct PlaylistsResponse: Codable {
    let items : [Playlist]
}

struct CategoryPlaylistResponse: Codable {
    let playlists: PlaylistsResponse
}

struct Playlist: Codable {
    let name: String
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let owner: UserResponse
}

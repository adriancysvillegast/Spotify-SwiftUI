//
//  TopTracksArtistsResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/24.
//

import Foundation

struct TopTracksArtistsResponse: Codable {
//    let tracks: [AudioTrackResponse]
    let tracks: [TopItemsArtistsResponse]
}


struct TopItemsArtistsResponse: Codable {
    let album: AlbumArtistResponse
    let artists: [ArtistsResponse]
    let id: String
    let name: String
    let previewUrl: String?
    let explicit: Bool
}

struct AlbumArtistResponse: Codable {
    let id: String
    let images: [APIImage]
    let name: String
}

//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/12/23.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: AlbumSearchResponse
    let artists: ArtistSearchResponse
    let playlists: PlaylistSearchResponse
    let tracks: TrackSearchResponse
}

struct AlbumSearchResponse: Codable {
    let items: [AlbumResponse]
}

struct ArtistSearchResponse: Codable {
    let items: [ArtistsResponse]
}

struct PlaylistSearchResponse: Codable {
    let items: [Playlist]
}

struct TrackSearchResponse: Codable {
    let items: [AudioTrackResponse]
}

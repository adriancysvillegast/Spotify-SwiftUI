//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import Foundation
import SwiftUI

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

// MARK: - Albums
struct AlbumsResponse: Codable {
    let items: [AlbumResponse]
}

// MARK: - AlbumResponse
struct AlbumResponse: Codable, Identifiable {
    let albumType: String
    let availableMarkets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    let artists: [ArtistsResponse]
}





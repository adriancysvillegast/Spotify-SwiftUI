//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import Foundation
import SwiftUI

struct AlbumsDetailsResponse: Codable {
    let albumType: String
    let artists: [ArtistsResponse]
    let availableMarkets: [String]
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items: [AudioTrackResponse]
}

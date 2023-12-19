//
//  FavoriteTracksResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 18/12/23.
//

import Foundation

struct FavoriteTracksResponse: Codable {
    let items: [TrackInfoResponse]
    let next: String?
    let previous: String?
    
}


struct TrackInfoResponse: Codable {
    let addedAt: String
    let track: AudioTrackResponse
}

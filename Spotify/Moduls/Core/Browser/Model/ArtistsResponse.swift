//
//  ArtistsResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import Foundation

struct ArtistsResponse: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let externalUrls: [String: String]
}

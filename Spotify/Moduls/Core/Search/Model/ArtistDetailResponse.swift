//
//  ArtistDetailResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/24.
//

import Foundation
import SwiftUI

struct ArtistDetailResponse: Codable {
    let followers: ArtistFollowers
    let genres: [String]
    let id: String
    let images: [APIImage]?
    let name: String
    let popularity: Int
    let type: String
}

struct ArtistFollowers: Codable {
    let total: Int
}

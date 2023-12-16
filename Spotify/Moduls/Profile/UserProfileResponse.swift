//
//  UserProfileResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 15/12/23.
//

import Foundation

struct UserProfileResponse: Codable {
    let country, displayName, id, email, product, type, uri: String
    let explicitContent: [String: Bool]
    let externalUrls: [String: String]
    let images: [APIImage]
}

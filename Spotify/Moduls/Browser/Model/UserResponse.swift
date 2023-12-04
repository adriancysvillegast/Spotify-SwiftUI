//
//  UserResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/12/23.
//

import Foundation

struct UserResponse: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
}

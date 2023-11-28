//
//  AuthResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import Foundation
import SwiftUI

struct AuthResponse: Codable {
    let accessToken : String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
}

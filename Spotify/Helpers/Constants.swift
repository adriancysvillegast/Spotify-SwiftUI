//
//  Constants.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import Foundation
import SwiftUI

struct Constants {
    // MARK: - Images
    
    static let imageLogIn = "backgroundImageLogIn"
    
    
    // MARK: - Messages or text on properties
    
    static let buttonLoginText = "Sign in with Spotify"
    
    // MARK: - URLS
    
    static let baseUrl: String = ProcessInfo.processInfo.environment["baseUrl"] ?? "https://api.spotify.com/v1"
    static let tokenAPIURL: String =  ProcessInfo.processInfo.environment["tokenAPIURL"] ?? "https://accounts.spotify.com/api/token"
    static let redirectURL = "https://github.com/adriancysvillegast"
    
    // MARK: - Tokens and IDS
    
    static let clientID: String = ProcessInfo.processInfo.environment["clientID"] ?? "4796bca77e3f4b5990102b3adfe91ae7"
    static let clienteSecret: String = ProcessInfo.processInfo.environment["clientSecret"]!
    
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    
    static var signInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let string = "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
        return URL(string: string)
    }
}

//
//  RecomendationResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 28/11/23.
//

import Foundation
import SwiftUI

struct RecomendationsResponse: Codable{
    
    let tracks: [AudioTrackResponse]
}

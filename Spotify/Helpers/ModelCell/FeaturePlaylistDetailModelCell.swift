//
//  FeaturePlaylistDetailModelCell.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import Foundation

struct FeaturePlaylistDetailModelCell {
    let id: String
    let image: URL?
    let name: String
    let owner: String
    let tracks: [TrackModelCell]
    let description: String
}

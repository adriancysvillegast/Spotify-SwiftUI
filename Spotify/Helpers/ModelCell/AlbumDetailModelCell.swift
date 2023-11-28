//
//  AlbumDetailModelCell.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/11/23.
//

import Foundation
import SwiftUI


struct AlbumDetailModelCell {
    let id: String
    let image: URL?
    let nameAlbum: String
    let nameArtist: String
    let tracks: [AudioTrackResponse]
}

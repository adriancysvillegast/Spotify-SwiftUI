//
//  TrackModelCell.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 28/11/23.
//

import Foundation
import SwiftUI

struct TrackModelCell: Hashable {
    let image: URL?
    let artists: String
    let explicit: Bool
    let id: String
    let name: String
    let previewUrl: URL?
}

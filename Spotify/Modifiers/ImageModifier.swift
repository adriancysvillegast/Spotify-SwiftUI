//
//  ImageModifier.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/12/23.
//

import SwiftUI

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .cornerRadius(12)
    }
}



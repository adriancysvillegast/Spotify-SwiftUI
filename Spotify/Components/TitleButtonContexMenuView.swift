//
//  TitleButtonContexMenuView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 12/1/24.
//

import SwiftUI

struct TitleButtonContexMenuView: View {
    // MARK: - Properties
    let name: String
    let icon: String
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text(name)
            Image(systemName: icon)
        }
    }
}

struct TitleButtonContexMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TitleButtonContexMenuView(name: "Add to a Playlist",
                                  icon: "star")
            .previewLayout(.fixed(width: 290, height: 30))
    }
}

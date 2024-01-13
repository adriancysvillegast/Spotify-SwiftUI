//
//  PlaylistListVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/1/24.
//

import SwiftUI

struct PlaylistListVerticalView: View {
    
    // MARK: - Properties
    let playlists: [ItemModelCell]
    let columnsRow = [GridItem(), GridItem()]
    
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columnsRow) {
                    ForEach(playlists, id: \.id) { item in
                        NavigationLink {
                            PlaylistDetailView(playlist: item)
                        } label: {
                            AlbumCoverView(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Playlists")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

//struct PlaylistListVerticalVew_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistListVerticalVew()
//    }
//}

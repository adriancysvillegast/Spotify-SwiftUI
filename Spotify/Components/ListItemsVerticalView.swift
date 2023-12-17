//
//  ListItemsVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 11/12/23.
//

import SwiftUI

struct ListItemsVerticalView: View {
    // MARK: - Properties
    @State var items: [ItemModelCell] = []
    var rows = [GridItem(), GridItem()]
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: rows) {
                ForEach(items, id: \.id) { item in
                    NavigationLink {
                        if item.isPlaylist {
                            PlaylistDetailView(playlist: item, viewModel: PlaylistDetailViewModel())
                        }else {
                            AlbumDetailView(album: item, viewModel: AlbumDetailViewModel())
                        }
                    } label: {
                        ItemCoverView(item: item)
                            .padding(.horizontal)
                    }
                    
                }
            }
        }
        .toolbar {
            // MARK: - Add playlists
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    CreateNewPlaylistView()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondary)
                            .cornerRadius(12)
                        
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                    }
                    .frame(width: 30, height: 30)
                }

            }
        }
    }
}

struct ListItemsVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsVerticalView()
    }
}

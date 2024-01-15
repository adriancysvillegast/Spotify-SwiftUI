//
//  PlaylistVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 11/12/23.
//

import SwiftUI

struct PlaylistVerticalView: View {
    // MARK: - Properties
    @StateObject var viewModel: LibraryViewModel = LibraryViewModel()
    
    var rows = [GridItem(), GridItem()]
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: rows) {
                ForEach(viewModel.playlists, id: \.id) { item in
                    NavigationLink {
                        PlaylistDetailView(playlist: item, viewModel: PlaylistDetailViewModel())
                    } label: {
                        ItemCoverView(item: item)
                            .contextMenu {
                                Button {
                                    viewModel.deleteUserPlaylist(playlist: item)
                                } label: {
                                    TitleButtonContexMenuView(name: "Delete", icon: "delete.left")
                                }
                            }
                    }
                    
                }
            }
        }
        .onAppear {
            viewModel.getPlaylists()
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
        PlaylistVerticalView()
    }
}

//
//  AlbumVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 18/12/23.
//

import SwiftUI

struct AlbumVerticalView: View {
    // MARK: - Properties
    @StateObject var viewModel: LibraryViewModel = LibraryViewModel()
    var rows = [GridItem(), GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: rows) {
                    ForEach(viewModel.albums, id: \.id) { item in
                        NavigationLink {
                            AlbumDetailView(album: item)
                        } label: {
                            ItemCoverView(item: item)
                                .contextMenu {
                                    Button {
                                        viewModel.deleteUserAlbum(album: item)
                                    } label: {
                                        TitleButtonContexMenuView(name: "Delete", icon: "delete.left")
                                    }
                                }
                        }
                        
                    }
                }
            }
            .navigationTitle("Albums")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getAlbums()
        }
    }
}

struct AlbumVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumVerticalView()
    }
}

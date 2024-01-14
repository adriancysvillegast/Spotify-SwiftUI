//
//  AlbumsListVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/24.
//

import SwiftUI

struct AlbumsListVerticalView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: BrowserViewModel = BrowserViewModel()
    
    let albums: [ItemModelCell]
    let newReleasesRow = [GridItem(), GridItem()]
    
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: newReleasesRow) {
                    ForEach(albums, id: \.id) { item in
                        NavigationLink {
                            AlbumDetailView(album: item)
                        } label: {
                            AlbumCoverView(item: item)
                                .contextMenu {
                                    Button {
                                        viewModel.addAlbumTofavorite(album: item)
                                    } label: {
                                        if item.wasAddedToFavoriteAlbums{
                                            TitleButtonContexMenuView(name: "Undo Favorite", icon: "heart.slash")
                                        }else{
                                            TitleButtonContexMenuView(name: "Favorite", icon: "heart")
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("New Releases")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

//struct AlbumsListVerticalView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumsListVerticalView()
//    }
//}

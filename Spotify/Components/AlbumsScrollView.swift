//
//  AlbumsScrollView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/1/24.
//

import SwiftUI

struct AlbumsScrollView: View {
    
    // MARK: - Properties
    let albums: [ItemModelCell]
    private let albumsRow = [GridItem(), GridItem()]
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    AlbumsListVerticalView(albums: albums)
                } label: {
                    HStack(spacing: 1) {
                        Text("New Releases")
                            .font(.title2)
                            .foregroundColor(.primary)
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: albumsRow) {
                    ForEach(albums, id: \.id) { item in
                        NavigationLink {
                            AlbumDetailView(album: item)
                        } label: {
                            AlbumCoverView(item: item)
                        }
                    }
                    
                }
            }
            .frame(height: 400)
            
        }
    }
}

//struct AlbumsScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumsScrollView()
//    }
//}

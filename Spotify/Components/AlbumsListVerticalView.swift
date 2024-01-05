//
//  AlbumsListVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/24.
//

import SwiftUI

struct AlbumsListVerticalView: View {
    
    // MARK: - Properties
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

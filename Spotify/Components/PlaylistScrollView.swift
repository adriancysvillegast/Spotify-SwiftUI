//
//  FeaturePlaylistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/12/23.
//

import SwiftUI

struct PlaylistScrollView: View {
    // MARK: - Properties
    let playlists: [ItemModelCell]
    let featureRow = [GridItem(), GridItem()]
    // MARK: - LifeCycle
    
    var body: some View {
        
        VStack {
            HStack {
//
                NavigationLink {
                    PlaylistListVerticalView(playlists: playlists )
                } label: {
                    HStack(spacing: 1) {
                        Text("Feature playlist")
                            .font(.title2)
                            .foregroundColor(.primary)
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: featureRow) {
                    ForEach(playlists, id: \.id) { item in
                        NavigationLink {
                            PlaylistDetailView(playlist: item)
                        } label: {
                            PlaylistCoverView(item: item)
                        }
                    }

                }
            }
            .frame(height: 400)
            
        }
    }
}

//struct FeaturePlaylistView_Previews: PreviewProvider {
//    static let feature: FeaturePlaylistResponse = Bundle.main.decode("FeaturePlaylist.json")
//    
//    static let playlist = feature.playlists.items.compactMap {
//        ItemModelCell(id: $0.id,
//                      nameItem: $0.name,
//                      creatorName: $0.owner.displayName,
//                      image: URL(string: $0.images.first?.url ?? "-"),
//                      description: "",
//                      isPlaylist: true
//        )
//    }
//    static var previews: some View {
//        PlaylistScrollView(playlists: playlist)
//    }
//}

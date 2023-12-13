//
//  FeaturePlaylistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/12/23.
//

import SwiftUI

struct FeaturePlaylistView: View {
    // MARK: - Properties
    let featureLists: [ItemModelCell]
    let featureRow = [GridItem(), GridItem()]
    // MARK: - LifeCycle
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
//                                            go to list releases
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
                    ForEach(featureLists, id: \.id) { item in
                        NavigationLink {
                            PlaylistDetailView(playlist: item, viewModel: PlaylistDetailViewModel())
                        } label: {
                            FeaturePlaylistCoverView(item: item)
                        }
                    }

                }
            }
            .frame(height: 400)
            
            Spacer()
        }
    }
}

struct FeaturePlaylistView_Previews: PreviewProvider {
    static let feature: FeaturePlaylistResponse = Bundle.main.decode("FeaturePlaylist.json")
    
    static let playlist = feature.playlists.items.compactMap {
        ItemModelCell(id: $0.id,
                      nameItem: $0.name,
                      creatorName: $0.owner.displayName,
                      image: URL(string: $0.images.first?.url ?? "-"),
                      description: "",
                      isPlaylist: true
        )
    }
    static var previews: some View {
        FeaturePlaylistView(featureLists: playlist)
    }
}

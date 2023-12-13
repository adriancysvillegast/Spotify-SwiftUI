//
//  FeaturePlaylistCoverView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import SwiftUI

struct FeaturePlaylistCoverView: View {
    
    // MARK: - Properties
    let item: ItemModelCell
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                VStack {
                    AsyncImage(url: item.image) { image in
                        image
                            .resizable()
                            .modifier(ImageModifier())
                        
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .frame(height: 150)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.nameItem)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Text(item.creatorName)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                    
            }
            
            
        }
        .frame(width: 150, height: 200)
    }
}

struct FeaturePlaylistCoverView_Previews: PreviewProvider {
    static let list: FeaturePlaylistResponse = Bundle.main.decode("FeaturePlaylist.json")
    static let playlist = list.playlists.items.compactMap {
        ItemModelCell(id: $0.id,
                           nameItem: $0.name,
                           creatorName: $0.owner.displayName,
                           image: URL(string: $0.images.first?.url ?? "-"),
                           description: "",
                      isPlaylist: true
        )
    }
    static var previews: some View {
        FeaturePlaylistCoverView(item: playlist[0])
    }
}

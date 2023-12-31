//
//  ItemView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import SwiftUI

struct AlbumCoverView: View {
    
    // MARK: - Poperties
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

// MARK: - Preview

//struct ItemView_Previews: PreviewProvider {
//
//    static let item: [AlbumResponse] = Bundle.main.decode("NewReleases.json")
//    
//    static let data : [NewReleasesModelCell] = item.map {
//        NewReleasesModelCell(
//            idAlbum: $0.id,
//            nameAlbum: $0.name,
//            nameArtist: $0.artists.first?.name ?? "-" ,
//            urlImage: URL(string: $0.images.first?.url ?? "-")
//        )
//    }
//    static var previews: some View {
//        CoverView(item: data[1])
//            .previewLayout(.fixed(width: 150, height: 200))
//    }
//}

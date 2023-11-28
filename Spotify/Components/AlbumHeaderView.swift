//
//  AlbumHeaderView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/11/23.
//

import SwiftUI

struct AlbumHeaderView: View {
    // MARK: - Properties
    let albumDetail: AlbumDetailModelCell
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            AsyncImage(url: albumDetail.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(12)
                
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            VStack(alignment: .center) {
                Text(albumDetail.nameAlbum)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .lineLimit(3)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    
                
                
                Text(albumDetail.nameArtist)
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                
            }
            .padding(.horizontal)
           
            Spacer()
        }
    }
}
//
//struct AlbumHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumHeaderView()
//    }
//}

//
//  PlaylistHeaderDetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import SwiftUI

struct PlaylistHeaderDetailView: View {
    // MARK: - Properties
    let playList: FeaturePlaylistDetailModelCell
    // MARK: - Body
    var body: some View {
        VStack {
            AsyncImage(url: playList.image) { image in
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
                Text(playList.name)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .lineLimit(3)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    
                
                
                Text(playList.owner)
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                
                
            }
            .padding(.horizontal)
           
            VStack {
                Text(playList.description)
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
            }
            .padding(.horizontal)
            Spacer()
        }
        
    }
}

//struct PlaylistHeaderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistHeaderDetailView()
//    }
//}

//
//  TrackCoverView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 29/11/23.
//

import SwiftUI

struct TrackCoverView: View {
    // MARK: - Properties
    let track: TrackModelCell
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 5) {
            VStack {
                AsyncImage(url: track.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                    
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text(track.name)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    if track.explicit {
                        Image(systemName: "e.square.fill")
                    }
                }
                
                Text(track.artists)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
        }
        .frame(width: 125, height: 160)
        
        
    }
}

struct TrackCoverView_Previews: PreviewProvider {
    static let track: TrackModelCell =
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "dad", explicit: true, id: "sdgfgsd", name: "fechcfgosdsdsdsdsdsdsdrias", previewUrl: URL(string: "jhshf"))
        
    static var previews: some View {
        TrackCoverView(track: track)
    }
}

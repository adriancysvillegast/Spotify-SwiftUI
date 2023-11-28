//
//  TrackListView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/11/23.
//

import SwiftUI

struct TrackListView: View {
    
    // MARK: - proeprties
    let tracks: [TrackModelCell]
    // MARK: - Body
    
    var body: some View {
        
            List {
                ForEach(tracks, id: \.id) { track in
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(track.name )
                                .font(.title3)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            if track.explicit {
                                Image(systemName: "e.square.fill")
                            }
                        }
                        
                        Text(track.artists)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                    }
                    .onTapGesture {
                        print(track.name)
                    }
                    
                }
            }
            .listStyle(.plain)
            
    }
}

//struct TrackListView_Previews: PreviewProvider {
//    static var album: AlbumsDetailsResponse = Bundle.main.decode("AlbumDetail.json")
//    static var tracks: [AudioTrackResponse] = album.tracks.items
//    
//    static var previews: some View {
//        TrackListView(track: tracks)
//    }
//}

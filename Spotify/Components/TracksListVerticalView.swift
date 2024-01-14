//
//  TracksListVerticalView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 12/1/24.
//

import SwiftUI

struct TracksListVerticalView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: BrowserViewModel = BrowserViewModel()
    let tracks: [TrackModelCell]
    private let rows = [GridItem(), GridItem()]
    let genreName: String
    
    @State var showTrack: Bool = false
    @State var trackSelectedId: String = "no"
    @State var trackSelectedName: String = "no"
    @State var showUserPlaylists: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: rows) {
                    ForEach(tracks, id: \.id) { track in
                        Button {
                            showTrack.toggle()
                            trackSelectedId = track.id
                        } label: {
                            TrackCoverView(track: track)
                                .contextMenu {
                                    Button {
                                        trackSelectedId = track.id
                                        trackSelectedName = track.name
                                        self.showUserPlaylists.toggle()
                                    } label: {
                                        TitleButtonContexMenuView(name: "Add to a Playlist", icon: "star")
                                    }
                                    
                                    Button {
                                        viewModel.addToFavoriteTracks(trackId: track.id)
                                    } label: {
                                        TitleButtonContexMenuView(name: "Favorite", icon: "heart")
                                    }
                                }
                        }
                    }
                }
                
                
            }
            .padding(.horizontal)
            .navigationTitle(genreName.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showTrack) {
                PlayView(id: $trackSelectedId)
            }
            .fullScreenCover(isPresented: $showUserPlaylists) {
                UserPlaylistAVMView(idTrack: $trackSelectedId, nameTrack: $trackSelectedName)
            }
            
        }
    }
    
    // MARK: - Methods
    
}

//struct TracksListVerticalView_Previews: PreviewProvider {
//    static var previews: some View {
//        TracksListVerticalView()
//    }
//}

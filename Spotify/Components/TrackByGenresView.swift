//
//  TrackByGenresView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 18/1/24.
//

import SwiftUI

struct TrackByGenresView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: BrowserViewModel = BrowserViewModel()
    
    let genreName: String
    @State var showTrack: Bool = false
    @State var trackSelectedId: String = "no"
    @State var trackSelectedName: String = "no"
    @State var showUserPlaylists: Bool = false
    
    private let rows = [GridItem(), GridItem()]
    // MARK: - Body
    
    
    var body: some View {
        ZStack {
            if viewModel.errorTracksByGenres{
                VStack {
                    Text("Error Trying to get Track")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
            }else if viewModel.trackfForGenre.isEmpty {
                LoadingView()
            }else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: rows) {
                        ForEach(viewModel.trackfForGenre, id: \.id) { track in
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
        .onAppear {
            viewModel.getTracksByGenre(genre: genreName)
        }
    }
}

//struct TrackByGenresView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackByGenresView()
//    }
//}

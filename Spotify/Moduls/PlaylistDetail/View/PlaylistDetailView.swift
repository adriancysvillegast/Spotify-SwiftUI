//
//  PlaylistDetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import SwiftUI

struct PlaylistDetailView: View {
    // MARK: - Propeties
    var playlist: ItemModelCell
    @StateObject var viewModel: PlaylistDetailViewModel
    @State var trackSelected: String = "no"
    @State var showTrack: Bool = false
    @State var showUserPlaylists: Bool = false
    @State var trackPressedId: String = "no"
    @State var trackPressedName: String = "no"
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if viewModel.showError {
                    Text("error")
                }else if let details = viewModel.playlistDetails{
                    VStack {
                        
                        VStack {
                            PlaylistHeaderDetailView(playList: details)
                        }
                        
                        // MARK: - Buttons
                        Group {
                            // MARK: - Play Button
                            
                            HStack(spacing: 15) {
                                Button {
                                    viewModel.playListOfTracks()
                                } label: {
                                    PlayButtonView()
                                }
                                
                                Button {
                                    viewModel.shufflePlaylistTracks()
                                } label: {
                                    ShuffleButtonView()
                                }

                                
                            }
                            .padding(.horizontal)

                        }
                        Spacer()
                        
                        // MARK: - List of tracks
                        Group {
                            List {
                                ForEach(details.tracks, id: \.id) { track in
                                    Button {
                                        trackSelected = track.id
                                        self.showTrack.toggle()
                                    } label: {
                                        LabelTrackView(track: track)
                                            .contextMenu {
                                                Button {
                                                    trackPressedId = track.id
                                                    trackPressedName = track.name
                                                    self.showUserPlaylists.toggle()
                                                } label: {
                                                    HStack {
                                                        Text("Add to a Playlist")
                                                        Image(systemName: "star")
                                                            
                                                    }
                                                }
                                                
                                            }
                                    }
                                    
                                }
                                
                            }
                            .listStyle(.plain)
                            
                        }
                        .frame(height: CGFloat(details.tracks.count) * 68)
                        
                    }
                }else {
                    ZStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                }
                
            }
            .sheet(isPresented: $showTrack) {
                PlayView(id: $trackSelected, viewModel: PlaySongViewModel())
                    .presentationDragIndicator(.visible)
            }
            
            .fullScreenCover(isPresented: $showUserPlaylists) {
//                show a view with the playlist by user
                UserPlaylistView(idTrack: $trackPressedId, nameTrack: $trackPressedName)
            }
            
        }
        .onAppear {
            viewModel.getDetailPlaylist(playlist: playlist)
        }
        
    }
}

//struct PlaylistDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistDetailView()
//    }
//}

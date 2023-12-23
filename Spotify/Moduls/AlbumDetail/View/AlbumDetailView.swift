//
//  AlbumDetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import SwiftUI

struct AlbumDetailView: View {
    
    // MARK: - Properties
    var album: ItemModelCell
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    @State var trackSelectedId: String = "no"
    @State var trackSelectedName: String = "no"
    @State var showTrack: Bool = false
    @State var showUserPlaylists: Bool = false
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                if viewModel.showError {
//                    showErrorvIEW
                }else if let album = viewModel.albumDetailCell{
                    VStack {
                        
                        // MARK: - Header
                        Group {
                            AlbumHeaderView(albumDetail: album)
                        }
                        .padding(.top, 0)
                        
                        // MARK: - Buttons
                        Group {
                            // MARK: - Play Button
                            
                            HStack(spacing: 15) {
                                Button {
                                    viewModel.playAllTracks()
                                } label: {
                                    PlayButtonView()
                                }
                                
                                Button {
                                    viewModel.saveAlbum(album: self.album)
                                } label: {
                                    FavoriteButtonView(isAdded: $viewModel.wasAdded)
                                }

                                
                            }
                            .padding(.horizontal)

                        }
                        
                        // MARK: - List of tracks
                        Group {
                            List {
                                ForEach(viewModel.tracks, id: \.id) { track in
                                    Button {
                                        trackSelectedId = track.id
                                        self.showTrack.toggle()
                                    } label: {
                                        LabelTrackView(track: track)
                                            .contextMenu {
                                                
                                                Button {
                                                    trackSelectedId = track.id
                                                    trackSelectedName = track.name
                                                    self.showUserPlaylists.toggle()
                                                } label: {
                                                    HStack {
                                                        Text("Add to a Playlist")
                                                        Image(systemName: "star")
                                                            
                                                    }
                                                }
//
//
                                                Button {
                                                    viewModel.addToFavoriteTracks(trackId: track.id)
                                                } label: {
                                                    HStack {
                                                        Text("Favorite")
                                                        Image(systemName:"heart")

                                                    }
                                                }
                                            }
                                    }
                                }
                                
                            }
                            .listStyle(.plain)
                        }
                        .frame(height: CGFloat(viewModel.tracks.count) * 68)
                        
                        // MARK: - Recomendation by random genre
                        Group {
                            TrackRecomendationView(tracks: viewModel.recomendedTracks, genreName: viewModel.genre, title: "More of")
                        }
                        .padding(.horizontal)
   
                    }
                }
            }
            .sheet(isPresented: $showTrack) {
                PlayView(id: $trackSelectedId, viewModel: PlaySongViewModel())
                    .presentationDragIndicator(.visible)
            }
            .fullScreenCover(isPresented: $showUserPlaylists) {
//                show a view with the playlist by user
                UserPlaylistAVMView(idTrack: $trackSelectedId, nameTrack: $trackSelectedName)
            }
            .alert(Text("Error"), isPresented: $viewModel.showError) {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }

            } message: {
                Text(viewModel.errorMessage)
            }
            
            .alert(Text("Error"), isPresented: $viewModel.errorAddingToPlaylist) {
                // MARK: - if exist an error adding a track to a playlist
                Button(role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }

            } message: {
                Text("\(trackSelectedName) wasn't added!")
            }
            
        }
        .onAppear {
            viewModel.reviewIfWasAddedBefore(album: self.album)
            viewModel.getDetail(album: album)
            viewModel.getGenresRecomendation()
            viewModel.getAudioTrackRecomendations()
        }
    }
}

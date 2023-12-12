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
    @StateObject var viewModel: AlbumDetailViewModel
    @State var trackSelected: String = "no"
    @State var showTrack: Bool = false
    
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
//                                        Task {
                                            trackSelected = track.id
                                            self.showTrack.toggle()
//                                        }
                                        
                                        
                                    } label: {
                                        VStack(alignment: .leading, spacing: 5) {
                                            HStack {
                                                Text(track.name )
                                                    .font(.title3)
                                                    .foregroundColor(.primary)
                                                    .lineLimit(1)

                                                if track.explicit {
                                                    Image(systemName: "e.square.fill")
                                                        .foregroundColor(.primary)
                                                }
                                            }

                                            Text(track.artists)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                
                            }
                            .listStyle(.plain)
                        }
                        .frame(height: CGFloat(viewModel.tracks.count) * 68)
                        
                        // MARK: - Recomendation by random genre
                        Group {
                            TrackRecomendationView(tracks: viewModel.recomendedTracks, genreName: viewModel.genre)
                        }
                        .padding(.horizontal)
   
                    }
                }
            }
            .sheet(isPresented: $showTrack) {
                PlayView(id: $trackSelected, viewModel: PlaySongViewModel())
                    .presentationDragIndicator(.visible)
            }
            .alert(Text("Error"), isPresented: $viewModel.showError) {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }

            } message: {
                Text(viewModel.errorMessage)
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

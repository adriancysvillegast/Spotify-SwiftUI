//
//  DetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    var album: NewReleasesModelCell
    @StateObject var viewModel: AlbumDetailViewModel
    
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
                        
                        // MARK: - List of tracks
                        Group {
                            TrackListView(tracks: viewModel.tracks)
                        }
                        .frame(height: CGFloat(viewModel.tracks.count) * 68)
                        
                        // MARK: - Recomendation by random genre
                        Group {
                            TrackRecomendationView(tracks: viewModel.recomendedTracks, genreName: viewModel.genre)
                        }
                        
                        
                        
                    }
                }
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
            viewModel.getDetail(album: album)
            viewModel.getGenresRecomendation()
            viewModel.getAudioTrackRecomendations()
        }
    }
}

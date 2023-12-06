//
//  PlaylistDetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import SwiftUI

struct PlaylistDetailView: View {
    // MARK: - Propeties
    var playlist: FeaturePlaylistModelCell
    @StateObject var viewModel: PlaylistDetailViewModel
    @State var trackSelected: String = "no"
    @State var showTrack: Bool = false
    
    
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
                        
                        Spacer()
                        
                        Group {
                            List {
                                ForEach(details.tracks, id: \.id) { track in
                                    Button {
                                        trackSelected = track.id
                                        self.showTrack.toggle()
                                    } label: {
                                        VStack(alignment: .leading, spacing: 5) {
                                            HStack {
                                                Text(track.name)
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

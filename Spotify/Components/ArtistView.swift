//
//  ArtistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/24.
//

import SwiftUI

struct ArtistView: View {
    // MARK: - Properties
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    let artist: ArtistModelCell
    
    let rowsTrack = [GridItem()]
    let rowsAlbums = [GridItem(), GridItem()]
    @State var trackSelected: String = ""
    @State var trackWasTapped: Bool = false
    
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            if !viewModel.artistDone {
                LoadingView()
            }else {
                VStack {
                    // MARK: - Header
                    
                    AsyncImage(url: viewModel.artistDetail?.artwork) { image in
                        image
                            .resizable()
                            .modifier(ImageModifier())
                            
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    // MARK: - Name and Details
                    
                    VStack(spacing: 10) {
                        
                        HStack {
                            Text(viewModel.artistDetail?.name ?? "-")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            
                            Spacer()
                        }
                        
                        
                    }
                    Spacer()
                    
                    // MARK: - Top Tracks
                    Group {
                        VStack {
                            
                            HStack {
                                Text("Top Tracks")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rowsTrack) {
                                    ForEach(viewModel.topTracksByArtist, id: \.id) { track in
                                        
                                        Button {
//                                            update sheet
                                            self.trackSelected = track.id
                                            self.trackWasTapped.toggle()
                                        } label: {
                                            TrackCoverView(track: track)
                                        }
                                    }
                
                                }
                            }
                            
                        }
                    }
                    
                    
                    // MARK: - Albums
                    Group {
                        VStack {
                            
                            HStack {
                                Text("Albums")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rowsAlbums) {
                                    
                                    ForEach(viewModel.albumsByArtist, id: \.id) { item in
                                        NavigationLink {
                                            AlbumDetailView(album: item)
                                        } label: {
                                            AlbumCoverView(item: item)
                                        }

                                        
                                    }
                
                                }
                            }
                            .frame(height: 400)
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    // MARK: - Details
                    Group {
                        
                        VStack {
                            HStack {
                                Text("More of \(artist.name)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            Spacer()
                            
                            if ((viewModel.artistDetail?.genres?.isEmpty) != nil) {
                                HStack {
                                    Text("Genres:")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Text((viewModel.artistDetail?.genres?.capitalized)!)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                Text("Followers:")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Text(viewModel.artistDetail?.followers ?? "0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                        
                        
                        
                        
                    }
                         
                }
                .padding(.horizontal)
                .sheet(isPresented: $trackWasTapped) {
                    PlayView(id: $trackSelected)
                }
                
            }
            
        }
        .onAppear {
            viewModel.getArtistDetail(id: artist.id)
        }
//        .navigationTitle(artist.name)
////        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct ArtistView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistView()
//    }
//}

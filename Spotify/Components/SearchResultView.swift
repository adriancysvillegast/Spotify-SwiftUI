//
//  SearchResultView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/12/23.
//

import SwiftUI

struct SearchResultView: View {
    // MARK: - Properties
    let tracks: [TrackModelCell]
    let artists: [ArtistModelCell]
    let albums: [ItemModelCell]
    
    @State var trackTapped: Bool = false
    @State var trackSelectedId: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Tracks
            Group {
                Section {
                    List {
                        ForEach(tracks, id: \.id) { track in
                            
                            Button {
//                                update sheet
                                trackSelectedId = track.id
                                trackTapped.toggle()
                            } label: {
                                LabelTrackView(track: track)
                            }
    
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: CGFloat(tracks.count)*70)
                    
                } header: {
                    HStack {
                        Text("Tracks")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            
            // MARK: - Artists
            Group {
                Section {
                    List {
                        ForEach(artists, id: \.id) { artist in
                            

                            NavigationLink {
//                                Create navigation of profile artist
                                ArtistView(artist: artist)
                            } label: {
                                HStack {
                                    AsyncImage(url: artist.artwork) { image in
                                        image
                                            .resizable()
                                            .modifier(ImageModifier())
                                        
                                    } placeholder: {
                                        Rectangle()
                                            .fill(.secondary)
                                    }
                                    .frame(width: 60, height: 60)
                                    
                                    Text(artist.name)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: CGFloat(tracks.count)*85)
                    
                } header: {
                    HStack {
                        Text("Artists")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            
            // MARK: - Albums
            
            Group {
                Section {
                    List {
                        ForEach(albums, id: \.id) { album in
                            NavigationLink {
                                Text(album.nameItem)
                            } label: {
                                HStack {
                                    AsyncImage(url: album.image) { image in
                                        image
                                            .resizable()
                                            .modifier(ImageModifier())

                                    } placeholder: {
                                        Rectangle()
                                            .fill(.secondary)
                                    }
                                    .frame(width: 60, height: 60)

                                    Text(album.nameItem)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: CGFloat(albums.count)*85)
                    
                } header: {
                    HStack {
                        Text("Albums")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            
        }
        .sheet(isPresented: $trackTapped) {
            PlayView(id: $trackSelectedId)
        }
        
    }
    
}

//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView()
//    }
//}

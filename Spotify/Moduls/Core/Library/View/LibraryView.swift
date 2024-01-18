//
//  LibraryView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import SwiftUI

struct LibraryView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: LibraryViewModel = LibraryViewModel()
    private var rows = [GridItem(), GridItem()]
    @State var trackWasTapped: Bool = false
    @State var trackTappedId: String = ""
    // MARK: - Body
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                List {
                    // MARK: - List
                    NavigationLink {
                        PlaylistVerticalView()
                    } label: {
                        
                        HStack {
                            Image(systemName: "music.note.list")
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            Text("Playlist")
                                .font(.title2)
                        }
                        
                    }
                    
                    NavigationLink {
                        AlbumVerticalView()
                    } label: {
                        
                        HStack {
                            Image(systemName: "music.note.list")
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            Text("Albums")
                                .font(.title2)
                            
                        }
                        
                    }
                }
                .navigationTitle("Library")
                .listStyle(.plain)
                .frame(height: 100)
                
                // MARK: - all albums and playlists
                LazyVGrid(columns: rows) {
                    ForEach(viewModel.allTracks, id: \.id) { item in
        
                        Button {
                            self.trackTappedId = item.id
                            trackWasTapped.toggle()
                        } label: {
                            ItemCoverView(item: item)
                                .contextMenu {
                                    Button {
                                        viewModel.deleteUserTrack(track: item)
                                    } label: {
                                        TitleButtonContexMenuView(name: "Delete", icon: "delete.left")
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
                
                
                Spacer()
            }
            .sheet(isPresented: $trackWasTapped) {
                PlayView(id: $trackTappedId)
            }
            
        }
        .onAppear {
            viewModel.getUserFavouriteTracks()
        }
        
        
        
    }
}


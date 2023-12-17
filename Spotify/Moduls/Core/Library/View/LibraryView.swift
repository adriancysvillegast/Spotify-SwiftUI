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
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                if viewModel.allTracks.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                }else {
                    List {
                        // MARK: - List
                        NavigationLink {
                            ListItemsVerticalView(items: viewModel.playlists)
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
                            ListItemsVerticalView(items: viewModel.albums)
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
                            NavigationLink {
                                if item.isPlaylist {
                                    PlaylistDetailView(playlist: item, viewModel: PlaylistDetailViewModel())
                                    
                                }else {
                                    AlbumDetailView(album: item, viewModel: AlbumDetailViewModel())
                                }
                            } label: {
                                ItemCoverView(item: item)
                                    .frame(height: 240)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                
            }
            .frame(maxHeight: .infinity)
            
        }
        .onAppear {
            viewModel.validateRefreshView()
        }
        
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

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
                        ListLibraryView()
                        
                    }
                    .navigationTitle("Library")
                    .listStyle(.plain)
                    .frame(height: 100)
                    
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
            viewModel.getPlaylist()
        }
        
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

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
                
                List {
                    // MARK: - List
                    ListLibraryView()
                    
                }
                .navigationTitle("Library")
                .listStyle(.plain)
                .frame(height: 100)
                
                LazyVGrid(columns: rows) {
                    ForEach(viewModel.playlists, id: \.id) { list in
                        NavigationLink {
                            Text(list.nameItem)
                        } label: {
                            ItemCoverView(item: list)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
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

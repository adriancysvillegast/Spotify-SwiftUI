//
//  BrowseView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import SwiftUI

struct BrowseView: View {
    
    
    // MARK: - Properties
    
    @StateObject var viewModel = BrowserViewModel()
    let newReleasesRow = [GridItem(), GridItem()]
    private var newReleases: [AlbumResponse] = []
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if viewModel.newReleasesCell.isEmpty {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }else {
                        
                        VStack {
                            //                            NewReleasesResponse
                            Group {
                                
                                VStack {
                                    HStack {
                                        Button {
//                                            go to list releases
                                        } label: {
                                            HStack(spacing: 1) {
                                                Text("New Releases")
                                                    .font(.title2)
                                                    .foregroundColor(.primary)
                                                
                                                Image(systemName: "chevron.forward")
                                                    .foregroundColor(.primary)
                                            }
                                        }

                                        Spacer()
                                        
                                    }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHGrid(rows: newReleasesRow) {
                                            ForEach(viewModel.newReleasesCell, id: \.idAlbum) { item in
                                                
                                                NavigationLink {
                                                    DetailView(album: item, viewModel: AlbumDetailViewModel())
                                                } label: {
                                                    CoverView(item: item)
                                                }
                                            }
                        
                                        }
                                    }
                                    .frame(height: 400)
                                    
                                    Spacer()
                                }
                            }
                            
                            Spacer()

                        }
                        .padding(.horizontal)
                        
                        
                    }
                }
                .navigationTitle("Browse")
            }
        }
        .onAppear {
            viewModel.getData()
            
            
        }
    }
}

// MARK: - Preview

struct BrowseView_Previews: PreviewProvider {
    
    static var previews: some View {
        BrowseView()
    }
}

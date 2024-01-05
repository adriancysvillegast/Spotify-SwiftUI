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
    @State var showProfile: Bool = false

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if viewModel.newReleasesCell.isEmpty &&
                        viewModel.featureListsCell.isEmpty &&
                        viewModel.alternativeListCell.isEmpty &&
                        viewModel.rockListCell.isEmpty &&
                        viewModel.houseListCell.isEmpty {
                        LoadingView()
                    }else {
                        
                        VStack(spacing: 10) {
                            // MARK: - Alternative
                            
                            Group {
                                TrackRecomendationView(tracks: viewModel.alternativeListCell, genreName: Constants.alternative, title: "Because you love")
                            }
                            .frame(height: 200)
                            

                            // MARK: - NewReleasesResponse
                            Group {
                                
                                VStack {
                                    HStack {
                                        NavigationLink {
                                            AlbumsListVerticalView(albums: viewModel.newReleasesCell)
                                        } label: {
                                            
                                            HStack(spacing: 1) {
                                                Text("New Releases")
                                                    .font(.title2)
                                                    .foregroundColor(.primary)
                                                
                                                Image(systemName: "chevron.forward")
                                                    .foregroundColor(.primary)
                                            }
                                        }

//                                        Button {
////                                            go to list releases
//                                        } label: {
//                                            HStack(spacing: 1) {
//                                                Text("New Releases")
//                                                    .font(.title2)
//                                                    .foregroundColor(.primary)
//
//                                                Image(systemName: "chevron.forward")
//                                                    .foregroundColor(.primary)
//                                            }
//                                        }

                                        Spacer()
                                        
                                    }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHGrid(rows: newReleasesRow) {
                                            ForEach(viewModel.newReleasesCell, id: \.id) { item in
                                                NavigationLink {
                                                    AlbumDetailView(album: item, viewModel: AlbumDetailViewModel())
                                                } label: {
                                                    AlbumCoverView(item: item)
                                                }
                                            }
                        
                                        }
                                    }
                                    .frame(height: 400)
                                    
                                    Spacer()
                                }
                            }
                            
                            // MARK: - Hard Rock
                            Group {
                                TrackRecomendationView(tracks: viewModel.rockListCell, genreName: Constants.hardRock, title: "Discover more of")
                            }
                            .frame(height: 200)
                            
                            // MARK: - FeaturePlaylist
                            Group {
                                FeaturePlaylistView(featureLists: viewModel.featureListsCell)
                            }
                            .frame(height: 450)
                            
                            // MARK: - House
                            Group {
                                TrackRecomendationView(tracks: viewModel.houseListCell, genreName: Constants.house, title: "Top")
                            }
                            .frame(height: 200)
                            

                        }
                        .padding(.horizontal)
                        
                        
                    }
                }
                .navigationTitle("Browse")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button {
                            showProfile.toggle()
                        } label: {
                            Image(systemName: "person.circle")
                                .foregroundColor(.primary)
                                .font(.largeTitle)
                        }
                    }
                    
                }
                
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
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

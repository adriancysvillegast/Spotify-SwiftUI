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
                        
                        VStack(spacing: 25) {
                            // MARK: - Alternative
                            
                            Group {
                                RecomendationScrollView(tracks: viewModel.alternativeListCell, genreName: Constants.alternative, title: "Because you love")
                            }
                            .frame(height: 200)

                            // MARK: - NewReleasesResponse
                            Group {
                                AlbumsScrollView(albums: viewModel.newReleasesCell)
                            }
                            
                            // MARK: - Hard Rock
                            Group {
                                RecomendationScrollView(tracks: viewModel.rockListCell, genreName: Constants.hardRock, title: "Discover more of")
                            }
                            .frame(height: 200)
                            
                            // MARK: - FeaturePlaylist
                            Group {
                                PlaylistScrollView(playlists: viewModel.featureListsCell)
                            }
                            .frame(height: 450)
                            
                            // MARK: - House
                            Group {
                                RecomendationScrollView(tracks: viewModel.houseListCell, genreName: Constants.house, title: "Top")
                            }
                            .frame(height: 200)

                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        
                        
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

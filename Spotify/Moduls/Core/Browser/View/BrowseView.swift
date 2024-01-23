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
    @State var showError: Bool = true
    let newReleasesRow = [GridItem(), GridItem()]
    @State var showProfile: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            if viewModel.newReleasesCell.isEmpty && viewModel.featureListsCell.isEmpty && !viewModel.errorData {
                LoadingView()
            }else if viewModel.errorData {
                VStack {
                    ErrorLoadingView()
                    Button {
                        viewModel.getData()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.green.opacity(0.8))
                            Text("Try Again")
                                .foregroundColor(.primary)
                        }
                        .frame(width: 140, height: 40)
                        .cornerRadius(12)
                        
                    }
                    
                }
            }else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    // MARK: - Alternative
                    Group {
                        RecomendationScrollView(tracks: viewModel.alternativeListCell, genreName: Constants.alternative, title: "Because you love")
                    }
                    
                    // MARK: - NewReleasesResponse
                    Group {
                        AlbumsScrollView(albums: viewModel.newReleasesCell)
                    }
                    
                    // MARK: - Hard Rock
                    Group {
                        RecomendationScrollView(tracks: viewModel.rockListCell, genreName: Constants.hardRock, title: "Discover more of")
                    }
                    // MARK: - FeaturePlaylist
                    Group {
                        PlaylistScrollView(playlists: viewModel.featureListsCell)
                    }
                    
                    // MARK: - House
                    Group {
                        RecomendationScrollView(tracks: viewModel.houseListCell, genreName: Constants.house, title: "Top")
                    }
                    
                    // MARK: - List
                    
                    Group {
                        OptionsListBrowserView()
                    }
                    .frame(height: 100)   
                    
                }
                .padding(.horizontal)
                .navigationBarTitle("Browser")
                .navigationBarTitleDisplayMode(.large)
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
                .fullScreenCover(isPresented: $showProfile) {
                    ProfileView()
                }
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

//
//  GenresListView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 18/1/24.
//

import SwiftUI

struct GenresListView: View {
    // MARK: - Properties

    @StateObject var viewModel: BrowserViewModel = BrowserViewModel()
    private var rows: [GridItem] = [GridItem(), GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if viewModel.genres.isEmpty && !viewModel.errorNameGenres {
                LoadingView()
            }else if viewModel.errorNameGenres{
                ErrorLoadingView()
            }else {
                VStack {
                    List {
                        ForEach(viewModel.genres, id: \.self) { genre in
                            
                            NavigationLink {
                                TrackByGenresView(genreName: genre)
                            } label: {
                                Text(genre)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .fontWeight(.medium)
                            }

                            
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Genres")
            }
            
        }
        .onAppear {
            viewModel.getGenres()
        }
        
    }
}
struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        GenresListView()
    }
}


//
//  SearchView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Properties
    @StateObject private var viewModel : SearchViewModel = SearchViewModel()
    @State private var searchTerm: String = ""
    @State private var searchWasTapped: Bool = false
    private var rows: [GridItem] = [GridItem(), GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            if viewModel.categories.isEmpty {
                LoadingView()
            }else {
                ScrollView(.vertical, showsIndicators: false) {
                    if searchTerm.isEmpty {
                        LazyVGrid(columns: rows) {
                            ForEach(viewModel.categories, id: \.id) { category in
                                NavigationLink {
                                    CategoryView(category: category)
                                } label: {
                                    CardCategoryView(category: category)
                                        .frame(height: 200)
                                }
                            }
                        }
                    } else if searchWasTapped{
                        if viewModel.tracksModel.isEmpty{
                            Spacer()
                            LoadingView()
                            Spacer()
                        }else{
                            SearchResultView(tracks: viewModel.tracksModel, artists: viewModel.artistModel, albums: viewModel.albumsModel)
                        }
                    } else {
                        EmptyView()
                    }
                    
                }
                .navigationTitle("Search")
                .searchable(text: $searchTerm, prompt: Text("Search"))
                .onChange(of: searchTerm, perform: { newValue in
                    viewModel.clearProperties(query: newValue)
                })
                .onSubmit(of: .search, {
                    searchWasTapped = true
                    viewModel.getSearchResult(searchTerm: searchTerm)
                })
                .padding(.horizontal)
                
            }
            
        }
        .task({
            viewModel.getCategories()
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

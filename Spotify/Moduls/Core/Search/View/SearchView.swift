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
    private var rows: [GridItem] = [GridItem(), GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            if viewModel.categories.isEmpty {
                VStack {
                    ProgressView()
                        .progressViewStyle(.automatic)
                    Text("Loading")
                        .foregroundColor(.secondary)
                }
                
            }else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: rows) {
                        ForEach(viewModel.categories, id: \.id) { category in
                            NavigationLink {
                                Text(category.name)
                            } label: {
                                CardCategoryView(category: category)
                                    .frame(height: 200)
                            }
                        }
                    }
                }
                .navigationTitle("Search")
                .searchable(text: $searchTerm, prompt: Text("Search"))
                .padding(.horizontal)
            }
           
        }
        .task({
            viewModel.getCategories()
        })
        .onAppear {
            
        }
        
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//
//  CategoryView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 27/12/23.
//

import SwiftUI

struct CategoryView: View {
    // MARK: - Properties
    let category: CategoriesModelCell
    @StateObject var viewModel = SearchViewModel()
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: viewModel.singleCategory?.artwork) { image in
                    VStack {
                        image
                            .resizable()
                            .modifier(ImageModifier())
                        
                        HStack {
                            Text(category.name)
                                .foregroundColor(.primary)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                                        
                            Spacer()
                        }
                        
                        Text("This section isn't available to show more\ninformation about the categories ")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                } placeholder: {
                    VStack {
                        ProgressView()
                            .progressViewStyle(.automatic)
                        Text("Loading")
                            .foregroundColor(.secondary)
                    }
                }

            }
            .padding(.horizontal)
            .task {
                viewModel.getCategoryDetail(idCategory: category.id)
            }
            
        }
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}

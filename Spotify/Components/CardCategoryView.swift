//
//  CardCategoryView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/12/23.
//

import SwiftUI

struct CardCategoryView: View {
    // MARK: - Properties
    var category: CategoriesModelCell
    // MARK: - Body
    
    var body: some View {
        ZStack {
            AsyncImage(url: category.artwork) { image in
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
        .cornerRadius(12)
        
    }
}

//struct CardGenresView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardCategoryView(name: "Rock")
//            .previewLayout(.fixed(width: 200, height: 150))
//    }
//}

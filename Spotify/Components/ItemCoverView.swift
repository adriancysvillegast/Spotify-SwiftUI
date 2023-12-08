//
//  ItemCoverView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 8/12/23.
//

import SwiftUI

struct ItemCoverView: View {
    
    // MARK: - Properties
    let item: ItemModelCell
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    AsyncImage(url: item.image) { image in
                        image
                            .resizable()
                            .modifier(ImageModifier())
                        
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
//                    .frame(height: 150)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.nameItem)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Text(item.creatorName)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                    
            }
            
            
        }
    }
}

//struct ItemCoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCoverView()
//    }
//}

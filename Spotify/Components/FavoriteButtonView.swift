//
//  FavoriteButtonView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 11/12/23.
//

import SwiftUI

struct FavoriteButtonView: View {
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondary)
                .cornerRadius(12)
            
            HStack {
                Image(systemName: "star")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.heavy)
                
                Text("Add")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            }
        }
        .frame(height: 60)
    }
}

struct FavoriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButtonView()
    }
}

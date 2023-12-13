//
//  ShuffleButtonView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/12/23.
//

import SwiftUI

struct ShuffleButtonView: View {
    // MARK: - Properties
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondary)
                .cornerRadius(12)
            
            HStack {
                Image(systemName: "shuffle")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.heavy)
                
                Text("Shuffle")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            }
        }
        .frame(height: 60)    }
}

struct ShuffleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleButtonView()
    }
}

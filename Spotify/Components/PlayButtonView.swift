//
//  PlayButtonView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 11/12/23.
//

import SwiftUI

struct PlayButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondary)
                .cornerRadius(12)
            
            HStack {
                Image(systemName: "play.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.heavy)
                
                Text("Play")
                    .font(.title2)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            }
        }
        .frame(height: 60)
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
            .previewLayout(.sizeThatFits)
    }
}

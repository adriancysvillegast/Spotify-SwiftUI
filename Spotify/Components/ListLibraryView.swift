//
//  ListLibraryView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 8/12/23.
//

import SwiftUI

struct ListLibraryView: View {
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        Group {
            NavigationLink {
                Text("inside Playlist")
            } label: {
                
                HStack {
                    Image(systemName: "music.note.list")
                        .foregroundColor(.red)
                        .font(.title2)
                    
                    Text("Playlist")
                        .font(.title2)
                    
                }
                
            }
            
            NavigationLink {
                Text("inside Albums")
            } label: {
                
                HStack {
                    Image(systemName: "music.note.list")
                        .foregroundColor(.red)
                        .font(.title2)
                    
                    Text("Albums")
                        .font(.title2)
                    
                }
                
            }
        }
    }
}

struct ListLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        ListLibraryView()
            .previewLayout(.sizeThatFits)
    }
}

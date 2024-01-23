//
//  OptionsListBrowserView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 18/1/24.
//

import SwiftUI

struct OptionsListBrowserView: View {
    
    // MARK: - Properties
    
    
    // MARK: - Body
    
    var body: some View {
            ZStack {
                
                VStack {
                    HStack {
                        Text("More to Explore")
                            .font(.title2)
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    
                    
                    
                    List {
                        NavigationLink {
                            GenresListView()
                        } label: {

                            HStack {
                                Image(systemName: "music.note.list")
                                    .foregroundColor(.red)
                                    .font(.title2)

                                Text("Genres")
                                    .font(.title2)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
    }
}

struct OptionsListBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsListBrowserView()
    }
}

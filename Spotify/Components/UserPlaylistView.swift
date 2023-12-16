//
//  UserPlaylistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/12/23.
//

import SwiftUI

struct UserPlaylistView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: PlaylistDetailViewModel = PlaylistDetailViewModel()
    
    @Binding var idTrack: String
    @Binding var nameTrack: String
    
    @State var playlistId: String = "no"
    @State var playlistName: String = "no"
    @State var showAlert: Bool = false
    @State var goToCreatePlaylist: Bool = false
    
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.playlistsUser, id: \.id) { playlist in
                        
                        Button {
                            playlistId = playlist.id
                            playlistName = playlist.nameItem
                            showAlert.toggle()
                        } label: {
                            HStack {
                                AsyncImage(url: playlist.image) { image in
                                    image
                                        .resizable()
                                        .modifier(ImageModifier())
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                .frame(width: 60, height: 60)
                                
                                Text(playlist.nameItem)
                                    .foregroundColor(.primary)
                                    .font(.title2)
                                
                            }
                        }
                        
                        
                    }
                }
                .listStyle(.automatic)
            }
            .onAppear {
                    viewModel.getUserPlaylists()
                
            }
            
            .sheet(isPresented: $goToCreatePlaylist, content: {
                CreatePlaylistsView()
            })
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Alert"),
                      message: Text("Do you want to add \(nameTrack) on \(playlistName)? "),
                      primaryButton: .destructive(Text("Cancel")),
                      secondaryButton: .default(Text("Add"), action: {
                    viewModel.saveItemOnPlaylist(item: idTrack, idPlaylist: playlistId)
                    
                }))
            }
            
            
            .toolbar {
                // MARK: - Add Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        goToCreatePlaylist.toggle()
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.secondary)
                                .cornerRadius(12)
                            
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        }
                        .frame(width: 30, height: 30)
                    }
                }
                
                // MARK: - Dismiss View
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.secondary)
                                .cornerRadius(12)
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        }
                        .frame(width: 30, height: 30)
                    }
                }
                
            }
        }
        
    }
}

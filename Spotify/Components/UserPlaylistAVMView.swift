//
//  UserPlaylistAVMView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 21/12/23.
//

import SwiftUI

struct UserPlaylistAVMView: View {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    
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
            .alert(Text("Success"), isPresented: $viewModel.successAddingToPlaylist) {
                // MARK: - if track was added
                Button(role: .destructive) {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Ok")
                }
            }
            
            .toolbar {

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

//struct UserPlaylistAVMView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPlaylistAVMView()
//    }
//}

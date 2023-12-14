//
//  UserPlaylistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/12/23.
//

import SwiftUI

struct UserPlaylistView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: PlaylistDetailViewModel = PlaylistDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var idTrack: String
    @Binding var nameTrack: String
    @State var playlistId: String = "no"
    @State var playlistName: String = "no"
    @State var showAlert: Bool = false
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
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Alert"),
                      message: Text("Do you want to add \(nameTrack) on \(playlistName)? "),
                      primaryButton: .destructive(Text("Cancel")),
                      secondaryButton: .default(Text("Add"), action: {
                    viewModel.saveItemOnPlaylist(item: idTrack, idPlaylist: playlistId)
                    
                }))
            }
            .onAppear {
                viewModel.getUserPlaylists()
            }
//            .alert(isPresented: $showError) {
//                Alert(title: Text("Error"),
//                      message: Text("We couldn't add \(nameTrack) to the playlist"),
//                      dismissButton: .destructive(Text("Ok"))
//                )
//            }
            .toolbar {
                // MARK: - Add Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//                        navigate to another view to create a playlist or present a Alert
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

//struct UserPlaylistView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserPlaylistView()
//    }
//}

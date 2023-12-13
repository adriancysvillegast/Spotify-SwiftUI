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
    @State var showAlert: Bool = false
    // MARK: - Body
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.playlistsUser, id: \.id) { item in
                    
                    Button {
                        showAlert.toggle()
//                        viewModel.saveItemOnPlaylist(item: idTrack, idPlaylist: item.id)
                    } label: {
                        HStack {
                            AsyncImage(url: item.image) { image in
                                image
                                    .resizable()
                                    .modifier(ImageModifier())
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            .frame(width: 60, height: 60)
                            
                            Text(item.nameItem)
                                .foregroundColor(.primary)
                                .font(.title2)

                        }
                    }
                    .alert(isPresented: $showAlert) {
                        
                        Alert(title: Text("Alert"),
                              message: Text("Do you want to add \(nameTrack) on \(item.nameItem)? "),
                              primaryButton: .destructive(Text("Cancel")),
                              secondaryButton: .default(Text("Add"), action: {
                            viewModel.saveItemOnPlaylist(item: idTrack, idPlaylist: item.id)
                            presentationMode.wrappedValue.dismiss()
                        }))
                    }
                    
                }
            }
            .listStyle(.automatic)
        }
        .onAppear {
            viewModel.getUserPlaylists()
        }
    }
}

//struct UserPlaylistView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserPlaylistView()
//    }
//}

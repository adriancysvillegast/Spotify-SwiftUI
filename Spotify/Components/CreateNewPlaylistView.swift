//
//  CreateNewPlaylistView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 17/12/23.
//

import SwiftUI

struct CreateNewPlaylistView: View {
    // MARK: - Property
    @StateObject var viewModel: LibraryViewModel = LibraryViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    
    
    // MARK: - Methods
    private func isClean() -> Bool {
        if name.count > 0 {
            return false
        }else {
            return true
        }
    }
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Spacer()
                TextField("Title Playlist", text: $name)
                    .frame(height: 60)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.secondary.opacity(0.2))
                    .padding(.horizontal)
            }
            .frame( height: 130)//width: 300,
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .navigationBarTitle("New Playlist")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.createNewPlaylist(name: name)
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondary)
                            .cornerRadius(12)
                        Text("Save")
                            .foregroundColor(isClean() ? .white : .red )
                    }
                    .frame(width: 50, height: 30)
                    
                }
                .disabled(isClean())
            }
        }
        .alert(isPresented: $viewModel.errorCreatingPlaylist) {
            Alert(
                title: Text("Error".uppercased()),
                message: Text("We got an error trying to create a new playlist"),
                dismissButton: .cancel(Text("Ok"),
                                       action: {
                                           viewModel.errorCreatingPlaylist = false
                                       })
            )
        }
        .alert(isPresented: $viewModel.wasAdded) {
            Alert(
                title: Text("Success".uppercased()),
                dismissButton: .cancel(Text("Ok"),
                                       action: {
                                           presentationMode.wrappedValue.dismiss()
                                       })
            )
        }
        
    }
}

struct CreateNewPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPlaylistView()
    }
}

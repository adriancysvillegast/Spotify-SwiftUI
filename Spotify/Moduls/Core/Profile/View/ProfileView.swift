//
//  ProfileView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - Properties
    
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            if viewModel.isloaded {
                VStack {
                    // MARK: - Photo
                    AsyncImage(url: viewModel.user?.image) { image in
                            image
                                .resizable()
                                .modifier(ImageModifier())
                            
                    } placeholder: {
                      ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .frame(height: 300)
                    
                    // MARK: - Name and email
                    
                    VStack {

                        HStack {
                            Text("User name:")
                                .font(.title3)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.user?.name ?? "-")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                            Spacer()
                            
                        }
                        
                        HStack {
                            Text("Email:")
                                .font(.title3)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.user?.email ?? "-")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Country:")
                                .font(.title3)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.user?.country ?? "-")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        
                    }
                    
                    Spacer()

                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .font(.title)
                                .foregroundColor(.primary)
                                
                        }

                    }
                }
                .padding(.horizontal, 12)
            }else {
                LoadingView()
            }
            
        }
        .onAppear {
            viewModel.getUserInfo()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

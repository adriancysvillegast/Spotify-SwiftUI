//
//  LogInView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import SwiftUI

struct LogInView: View {
    
    // MARK: - Properties
    @StateObject var manager = AuthManager.shared
    
    @State var showWeb: Bool = false
    @State var showAlert: Bool = false
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
//            BACKGROUND
            Image(Constants.imageLogIn)
                .resizable()
                .scaledToFill()
                .blur(radius: 2, opaque: false)
                .edgesIgnoringSafeArea(.all)
                
                
            
            VStack {
                HStack {
                    Text("Spotify")
                        .font(.system(size: 45, weight: .heavy, design: .serif))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    
                
                Spacer()
                
                Text("Listen To Millions\nOf Songs on\nThe Go")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                
                Spacer()
                
                Button {
                    self.showWeb.toggle()
                } label: {
                    Text("Log in with Spotify")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .customGrayLight,
                                    .customGrayMedium], startPoint: .top, endPoint: .bottom)
                        )
                        .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
                }
                .buttonStyle(CustomButtonModifier())
                .sheet(isPresented: self.$showWeb) {
                    AuthView()
                        .presentationDragIndicator(.visible)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(manager.errorLogInMessage ?? "-"), dismissButton: .default(Text("Close")))
                }
            }
            .padding(.horizontal, 100)
    
        }
        .environmentObject(manager)
    }
}

// MARK: - Preview

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

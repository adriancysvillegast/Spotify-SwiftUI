//
//  ContentView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthManager.shared
    
    var body: some View {

        if authManager.accessToken != nil{
            TabBarView()
        }else {
            LogInView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

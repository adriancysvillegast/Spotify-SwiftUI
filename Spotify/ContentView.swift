//
//  ContentView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        if AuthManager.shared.isSignedIn {
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

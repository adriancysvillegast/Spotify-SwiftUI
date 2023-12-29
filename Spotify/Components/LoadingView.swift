//
//  LoadingView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 28/12/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.automatic)
            Text("Loading")
                .foregroundColor(.secondary)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

//
//  ErrorLoadingView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/1/24.
//

import SwiftUI

struct ErrorLoadingView: View {
    
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.gray.opacity(0.3))
            
            VStack(alignment: .center, spacing: 30) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                    
                
                Text("Whe got an error when trying load data.\nPlease try to make sure that your network is working")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
            }
            
            .padding(.horizontal)
            .padding(.vertical)
        }
        .frame(width: 200,height: 200)
        .cornerRadius(12)
        .padding(.horizontal)
        
        
        
        
    }
}

struct ErrorLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorLoadingView()
    }
}

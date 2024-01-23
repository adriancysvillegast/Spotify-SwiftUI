//
//  CustomButtonModifier.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import SwiftUI

struct CustomButtonModifier: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background {
                configuration.isPressed ? LinearGradient(
                    colors: [
                        Color.green,
                        Color.green.opacity(0.6)
                    ],
                    startPoint: .top, endPoint: .bottom) :
                LinearGradient(
                    colors: [
                        Color.green.opacity(0.6),
                        Color.green],
                    startPoint: .top, endPoint: .bottom)
                
            }
            .cornerRadius(40)
    }
}

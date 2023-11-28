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
                    colors: [.customGrayMedium,
                             .customGrayLight],
                    startPoint: .top, endPoint: .bottom) :
                LinearGradient(
                    colors: [.customGrayLight,
                             .customGrayMedium],
                    startPoint: .top, endPoint: .bottom)
                
            }
            .cornerRadius(40)
    }
}

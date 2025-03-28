//
//  ScaledButtonStyle.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI

struct ScaledButtonStylePrimary: ButtonStyle {
  
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.05 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                .sensoryFeedback(.impact, trigger: configuration.isPressed )
        }
}

struct ScaledButtonStyleSecondary: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                
                .foregroundStyle(.contentAccent)
                .overlay(
                    Capsule()
                        .stroke(.contentAccent, lineWidth: 1)
                )
                .scaleEffect(configuration.isPressed ? 1.05 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                .sensoryFeedback(.impact, trigger: configuration.isPressed )
        }
}

//
//  ScaledButtonStyle.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI

struct ScaledButtonStylePrimary: ButtonStyle {
  
    func makeBody(configuration: Configuration) -> some View {
        ScaledButton(configuration: configuration)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.05 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                .sensoryFeedback(.impact, trigger: configuration.isPressed )
        }
    
    struct ScaledButton: View {
            let configuration: ButtonStyle.Configuration
            @Environment(\.isEnabled) private var isEnabled: Bool
            var body: some View {
                configuration.label.background(isEnabled ? Color.blue : Color.contentDisabled)
            }
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

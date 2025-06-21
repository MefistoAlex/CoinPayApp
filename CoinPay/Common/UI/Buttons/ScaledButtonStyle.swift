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
                .contentShape(Capsule())
                .sensoryFeedback(.impact, trigger: configuration.isPressed )
                
        }
    
    struct ScaledButton: View {
            let configuration: ButtonStyle.Configuration
            @Environment(\.isEnabled) private var isEnabled: Bool
            var body: some View {
                configuration.label
                    .glassEffect(.regular.interactive(isEnabled).tint(isEnabled ? Color.ultramarine : Color.contentDisabled), in: Capsule())
            }
    }
}

struct ScaledButtonStyleSecondary: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ScaledButton(configuration: configuration)
                .foregroundStyle(.contentAccent)
                .contentShape(Capsule())
                .sensoryFeedback(.impact, trigger: configuration.isPressed )
        }
    
    struct ScaledButton: View {
            let configuration: ButtonStyle.Configuration
            @Environment(\.isEnabled) private var isEnabled: Bool
            var body: some View {
                configuration.label
                    .glassEffect(.regular.interactive(isEnabled), in: Capsule())
            }
    }
}

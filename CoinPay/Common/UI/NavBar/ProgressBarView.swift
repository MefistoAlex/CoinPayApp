//
//  ProgressBarView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//
import SwiftUI

struct ProgressBarView: View {
    var step: Int
    var totalSteps: Int
    var body: some View {
        GeometryReader { geometry in
            let passedStepsWidth = CGFloat(geometry.size.width) / CGFloat(totalSteps) * CGFloat(step)
            let leftStepsWidth = CGFloat(geometry.size.width) - passedStepsWidth
            HStack(spacing: 0) {
                Capsule()
                    .frame(width: passedStepsWidth, height: 8)
                    .foregroundStyle(.ultramarine)
                    .glassEffect()
                Capsule()
                    .frame(width: leftStepsWidth, height: 8)
                    .foregroundStyle(Color.clear)
            }
            .glassEffect()
        }
        .frame(maxWidth: .infinity)
    }
}

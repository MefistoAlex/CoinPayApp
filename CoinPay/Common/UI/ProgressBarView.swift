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
    var passedStepsWidth: CGFloat {
        return CGFloat((UIScreen.main.bounds.width / CGFloat(totalSteps)) * CGFloat(step))
    }
    var leftStepsWidth: CGFloat {
        return CGFloat(UIScreen.main.bounds.width - passedStepsWidth)
    }
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .frame(width: passedStepsWidth, height: 4)
                .foregroundStyle(.blue)
            Rectangle()
                .frame(width: leftStepsWidth, height: 4)
                .foregroundStyle(Color.neutralGray)
        }
    }
}

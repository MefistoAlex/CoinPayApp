//
//  DarkGradient.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.06.2025.
//

import SwiftUI

struct DarkGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops:
                                [.init(color: .darkGradientBlack, location: 0.30),
                                 .init(color: .darkGradientBlue, location: 0.77),
                                 .init(color: .darkGradientPink, location: 1.0)]),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
        .ignoresSafeArea()
    }
}

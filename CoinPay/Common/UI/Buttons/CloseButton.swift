//
//  CloseButton.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: { action() }, label: {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .padding()
                .contentShape(Circle())
            })
            .buttonStyle(PlainButtonStyle())
    }
}

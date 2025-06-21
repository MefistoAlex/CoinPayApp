//
//  NavBarView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.06.2025.
//

import SwiftUI
import ComposableArchitecture




struct NavBarView: View {
    @Environment(\.dismiss) private var dismiss
    var totalSteps: Int
    var step: Int
    let isBackButtonHidden: Bool
    var title: String?
    var subtitle: String?
    var image: Image?
    var backButtonAction: () -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                backButton
                    .padding(.leading, 16)
                    .opacity(isBackButtonHidden ? 0 : 1)
                
                Spacer()
                
                titleSection
                
                Spacer()
                
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    Spacer()
                }
            }
            .padding(.vertical, 8)
            
            ProgressBarView(step: step, totalSteps: totalSteps)
                .padding(.horizontal, 16)
        }
        .frame(width: .infinity, height: 32)
    }
    
    @ViewBuilder
    var backButton: some View {
           Button(action: {
                backButtonAction()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.primary)
            }
            .frame(width: 44, height: 44)
            .contentShape(Circle())
            .glassEffect(.regular.interactive(), in: Circle())
    }
    
    @ViewBuilder
    var titleSection: some View {
        VStack {
            if let title = title {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fontDesign(.rounded)
    }
}

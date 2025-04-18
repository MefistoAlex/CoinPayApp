//
//  CreateAccountView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

struct CreateAccountView: View {
    @Bindable private var store: StoreOf<CreateAccountReducer>
    
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    var body: some View {
        VStack {
            ProgressView(step: 1, totalSteps: 3)
            
            Button(action: { self.store.send(.signUpButtonTapped) }) {
                Text("Verify Phone")
                    .foregroundStyle(.white)
            }
            Text("Create Account View")
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { self.store.send(.backButtonTapped) }) {
                    Image(.backArrow)
                        .foregroundStyle(.secondary)
                }
            }
        }
        
    }
}

struct ProgressView: View {
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

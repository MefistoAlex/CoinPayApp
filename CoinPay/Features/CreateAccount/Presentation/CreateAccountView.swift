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
        Button(action: { self.store.send(.signUpButtonTapped) }) {
            Text("Verify Phone")
                .foregroundStyle(.white)
        }
        Text("Create Account View")
    }
}

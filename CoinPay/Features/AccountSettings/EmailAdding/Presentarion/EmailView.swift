//
//  EmailView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 19.06.2025.
//

import SwiftUI
import ComposableArchitecture

struct EmailView: View {
    @Bindable private var store: StoreOf<EmailReducer>
    
    init(store: StoreOf<EmailReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Add Email")) {
                    TextField("Email", text: $store.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle("Email")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

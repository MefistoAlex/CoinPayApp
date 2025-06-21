//
//  PersonalInfoView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 19.06.2025.
//

import SwiftUI
import ComposableArchitecture

struct PersonalInfoView: View {
    @Bindable private var store: StoreOf<PersonalInfoReducer>
    
    init(store: StoreOf<PersonalInfoReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
                Section(header: Text("Personal Information")) {
                    // Add your form fields here
                    Text("Name")
                    Text("Email")
                    Text("Phone Number")
                }
            }
            .navigationTitle("Personal Info")
    }
}

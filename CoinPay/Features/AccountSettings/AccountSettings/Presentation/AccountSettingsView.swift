//
//  AccountSettingsView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.06.2025.
//

import SwiftUI
import ComposableArchitecture
import Loco

struct AccountSettingsView: View {
    @Bindable private var store: StoreOf<AccountSettingsReducer>
    init(store: StoreOf<AccountSettingsReducer>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            NavBarContainer {
                CountryResidenceView(
                    store: store.scope(
                        state: \.countryResidenceState,
                        action: \.countryResidence
                    )
                )
            } backButtonAction: {
            }
            
        } destination: { store in
            switch store.case {
            
            default:
                EmptyView() // Placeholder for other cases
            }
        }
    }
}

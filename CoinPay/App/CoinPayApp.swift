//
//  CoinPayApp.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI
import ComposableArchitecture
import Foundation
import Location
import DataPersistance

@main
struct CoinPayApp: App {
    
    @Dependency(\.dataBaseProvider) private var dataBaseProvider
    
    init() {
        LocationManager.shared.requestLocation()
    }
    
    var appStore = Store(initialState: .init(), reducer: { AppReducer() })
    var body: some Scene {
        WindowGroup {
            switch appStore.appState {
            case .onboarding:
                OnboardingView(store: appStore.scope(state:\.onboardingState, action: \.onboarding))
            case .registration:
                AuthorisationView(store: appStore.scope(state:\.authorisationState, action: \.authorisation))
            }
        }
        .modelContainer(dataBaseProvider.container)
    }
}

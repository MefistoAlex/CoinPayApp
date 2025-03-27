//
//  CoinPayApp.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct CoinPayApp: App {
    var appStore = Store(initialState: .init(), reducer: { AppReducer() })
    var body: some Scene {
        WindowGroup {
            switch appStore.appState {
            case .onboarding:
                ContentView()
            }
        }
    }
}

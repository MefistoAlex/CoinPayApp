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
import IQKeyboardManagerSwift
import Combine

@main
struct CoinPayApp: App {
    
    var cancellables = Set<AnyCancellable>()
    
    @Dependency(\.dataBaseProvider) private var dataBaseProvider
    @Dependency(\.usersDataSource) private var usersDataSource
    init() {
//        IQKeyboardManager.shared.isEnabled = true
        LocationManager.shared.requestLocation()
        usersDataSource.clearAllUsers()
            .sink { completion in
                switch completion {
                case .finished:
                    print("All users deleted successfully.")
                case .failure(let error):
                    print("Failed to delete all users: \(error.localizedDescription)")
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
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

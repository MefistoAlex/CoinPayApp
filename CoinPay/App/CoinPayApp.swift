//
//  CoinPayApp.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI
import ComposableArchitecture
import Foundation
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CoinPayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
    }
}

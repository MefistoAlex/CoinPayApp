//
//  AppReduser.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 27.03.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppReducer {
    enum AppState {
        case onboarding
        case registration
        case accountSettings
    }
    
    @ObservableState
    struct State {
       
        var appState: AppState
        var onboardingState: OnboardingReducer.State
        var authorisationState: AuthorisationReducer.State
        var accountSettingsState: AccountSettingsReducer.State
        
        init() {
            appState = .onboarding
            onboardingState = OnboardingReducer.State()
            authorisationState = AuthorisationReducer.State()
            accountSettingsState = AccountSettingsReducer.State()
        }
    }
    
    enum Action {
        case onboarding(OnboardingReducer.Action)
        case authorisation(AuthorisationReducer.Action)
        case accountSettings(AccountSettingsReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.onboardingState, action: \.onboarding) {
            OnboardingReducer()
        }
        Scope(state: \.authorisationState, action: \.authorisation) {
            AuthorisationReducer()
        }
        Scope(state: \.accountSettingsState, action: \.accountSettings) {
            AccountSettingsReducer()
        }
        Reduce { state, action in
            switch action {
            case .onboarding(\.onboardingFinished):
                state.appState = .registration
                return .none
            
            case .onboarding(_):
                return .none
            case .authorisation(.authorisationFinished(let user)):
                state.accountSettingsState.user = user
                state.appState = .accountSettings
                return .none
            case .authorisation(_):
                return .none
            case .accountSettings(_):
                return .none
            }
        }
    }
}

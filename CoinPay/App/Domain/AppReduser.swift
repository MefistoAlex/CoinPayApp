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
    }
    
    @ObservableState
    struct State {
       
        var appState: AppState
        var onboardingState: OnboardingReducer.State
        var authorisationState: AuthorisationReducer.State
        
        init() {
            appState = .onboarding
            onboardingState = OnboardingReducer.State()
            authorisationState = AuthorisationReducer.State()
        }
    }
    
    enum Action {
        case onboarding(OnboardingReducer.Action)
        case authorisation(AuthorisationReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.onboardingState, action: \.onboarding) {
            OnboardingReducer()
        }
        Scope(state: \.authorisationState, action: \.authorisation) {
            AuthorisationReducer()
        }
        Reduce { state, action in
            switch action {
            case .onboarding(\.onboardingFinished):
                state.appState = .registration
                return .none
            
            case .onboarding(_):
                return .none
            case .authorisation(_):
                return .none
            }
        }
    }
}

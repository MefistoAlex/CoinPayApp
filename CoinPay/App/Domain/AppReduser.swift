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
        
        init() {
            appState = .onboarding
            onboardingState = OnboardingReducer.State()
        }
    }
    
    enum Action {
        case onboarding(OnboardingReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.onboardingState, action: \.onboarding) {
            OnboardingReducer()
        }
        Reduce { state, action in
            switch action {
            case .onboarding(\.onboardingFinished):
                state.appState = .registration
                return .none
            
            case .onboarding(_):
                return .none
            }
        }
    }
}

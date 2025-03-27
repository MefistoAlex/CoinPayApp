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
    }
    
    @ObservableState
    struct State {
       
        var appState: AppState
        init() {
            appState = .onboarding
        }
    }
    
    enum Action {
        case onboardingFinished
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onboardingFinished:
                return .none
            }
        }
    }
}

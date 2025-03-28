//
//  OnboardingReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 27.03.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct OnboardingReducer {
    @ObservableState
    struct State: Equatable {
        let advantages = Advantages.allCases
        var selectedImageIndex = 0
    }
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextButtonTapped
        case onboardingFinished
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .onboardingFinished:
                return .none
            case .nextButtonTapped:
                if state.selectedImageIndex < state.advantages.count - 1 {
                    state.selectedImageIndex += 1
                } else {
                    return .send(.onboardingFinished)
                }
                return .none
            }
        }
    }
}

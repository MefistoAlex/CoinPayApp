//
//  CreateAccountReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CreateAccountReducer: Equatable {
    @ObservableState
    struct State: Equatable {
        var phoneCode: String = "+380"
        var phoneNumber: String = ""
        var pasword: String = ""
        var isPasswordShowing = false
        var isSignUpButtonEnabled = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case signUpButtonTapped
        case passwordVisibilityButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .signUpButtonTapped:
                return .none
            case .passwordVisibilityButtonTapped:
                return .none
            }
        }
    }
}

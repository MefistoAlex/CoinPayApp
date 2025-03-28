//
//  ConfirmPhoneReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ConfirmPhoneReducer: Equatable {
    @ObservableState
    struct State: Equatable {
        var phoneNumber: String = ""
        var confirmationCode = false
        var isVerifyNumberButtonEnabled = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case resendButtonTapped
        case verifyButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .resendButtonTapped:
                return .none
            case .verifyButtonTapped:
                return .none
            }
        }
    }
}

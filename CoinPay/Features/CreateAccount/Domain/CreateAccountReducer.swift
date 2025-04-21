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
    enum Constants {
        static let phoneCode = "🇺🇦 +380"
        static let stepsCount = 3
        static let currentStep = 1
    }
    private let id = UUID()
    static func == (lhs: CreateAccountReducer, rhs: CreateAccountReducer) -> Bool {
        lhs.id == rhs.id
    }
      
    @ObservableState
    struct State: Equatable {
        var countries: [CountrySection] = []
        var phoneCode: String = Constants.phoneCode
        var phoneNumber: String = ""
        var password: String = ""
        var isPasswordShowing = false
        var isSignUpButtonEnabled = false
        var focusedField: Field?
        
        enum Field: String, Hashable {
            case phoneNumber, password
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case signUpButtonTapped
        case passwordVisibilityButtonTapped
        case backButtonTapped
        case phoneCodeButtonTaped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.phoneNumber):
                state.isSignUpButtonEnabled = getSignUpButtonEnable(state: state)
                return .none
            case .binding(\.password):
                state.isSignUpButtonEnabled = getSignUpButtonEnable(state: state)
                return .none
            case .binding(_):
                return .none
            case .signUpButtonTapped:
                return .none
            case .passwordVisibilityButtonTapped:
                state.isPasswordShowing.toggle()
                return .none
            case .backButtonTapped:
                return .none
            case .phoneCodeButtonTaped:
                return .none
            }
        }
    }
    
    private func getSignUpButtonEnable(state: State) -> Bool {
        return !state.phoneNumber.isEmpty && !state.password.isEmpty
    }
}

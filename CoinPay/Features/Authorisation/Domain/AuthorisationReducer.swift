//
//  AuthorisationReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AuthorisationReducer {
    enum Constants {
        static let termsURL = URL(string: "https://www.google.com")!
        static let policyURL = URL(string: "https://www.youtube.com")!
    }
    
    @Reducer
    enum Path: Equatable {
        case createAccount(CreateAccountReducer)
        case confirmPhone(ConfirmPhoneReducer)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var createAccountState: CreateAccountReducer.State = .init()
        var confirmPhoneState: ConfirmPhoneReducer.State = .init()
        
        var presentedURL: URL?
        var policy: URL?
    }
    enum Action: BindableAction {
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
        case signUpButtonTapped
        case logInButtonTapped
        case termsButtonTapped
        case policyButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            
            case .signUpButtonTapped:
                state.path.append(.createAccount(.init()))
                return .none
            case .logInButtonTapped:
                return .none
            case .termsButtonTapped:
                state.presentedURL = Constants.termsURL
                return .none
            case .policyButtonTapped:
                state.presentedURL = Constants.policyURL
                return .none
            case .binding(_):
                return .none
            case .path(.element(id: _, action: .createAccount(.accountCreated(phoneNumber: let phoneNumber, password: let password)))):
                state.confirmPhoneState.phoneNumber = phoneNumber
                state.confirmPhoneState.password = password 
                state.path.append(.confirmPhone(state.confirmPhoneState))
                return .none
            case .path(.element(id: let id, action: .createAccount(.backButtonTapped))):
                state.path.pop(from: id)
                return .none
            case .path(.element(id: let id, action: .confirmPhone(.backButtonTapped))):
                state.path.pop(from: id)
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

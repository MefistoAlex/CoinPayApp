//
//  EmailReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 19.06.2025.
//

import SwiftUI
import ComposableArchitecture
import CountryPicker
import Loco

@Reducer
struct EmailReducer: Equatable {
    enum Constants {
        static let stepsCount = 4
        static let currentStep = 1
    }
    
    static func == (lhs: EmailReducer, rhs: EmailReducer) -> Bool {
        return true
    }
    
    @Dependency(\.countriesUseCase) private var countriesUseCase
    
    @ObservableState
    struct State: Equatable {
        var email: String = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            }
        }
    }
}

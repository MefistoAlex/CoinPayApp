//
//  CountryResidenceReduser.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.06.2025.
//

import SwiftUI
import ComposableArchitecture
import CountryPicker
import Loco

@Reducer
struct CountryResidenceReducer: Equatable {
    enum Constants {
        static let stepsCount = 4
        static let currentStep = 1
    }
    
    static func == (lhs: CountryResidenceReducer, rhs: CountryResidenceReducer) -> Bool {
        return true
    }
    
    @Dependency(\.countriesUseCase) private var countriesUseCase
    
    @ObservableState
    struct State: Equatable {
        @Presents var countrySelectionState:  PhoneCodeSelectionReducer.State?
        var country: Country?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case countrySelectionAction(PresentationAction<PhoneCodeSelectionReducer.Action>)
        case countryButtonTapped
        case continueButtonTapped
        case countrySelected(Country)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .countrySelectionAction(.presented(.countrySelected(let country))):
                state.country = country
                return .none
            case .countrySelectionAction(_):
                return .none
            case .countryButtonTapped:
                state.countrySelectionState = .init()
                return .none
            case .continueButtonTapped:
                guard let country = state.country else { return .none }
                return .send(.countrySelected(country))
            case .countrySelected(let country):
                return .none
            }
        }
        .ifLet(\.$countrySelectionState, action: \.countrySelectionAction) {
            PhoneCodeSelectionReducer()
        }
    }
}

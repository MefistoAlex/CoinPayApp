//
//  CountryResidenceReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.06.2025.
//

import SwiftUI
import ComposableArchitecture
import CountryPicker

@Reducer
struct AccountSettingsReducer {
    enum Constants {
        static let stepsCount = 3
        static let currentStep = 1
    }
    @Reducer
    enum Path: Equatable {
        case personalInfo(PersonalInfoReducer)
        case email(EmailReducer) 
    }
    
    @Dependency(\.countriesUseCase) private var countriesUseCase
    @ObservableState
    struct State {
        var countryResidenceState: CountryResidenceReducer.State = .init()
        var emailState: EmailReducer.State = .init()
        var personalInfoState: PersonalInfoReducer.State = .init()
        var user: User?
        var path = StackState<Path.State>()
    }
    
    enum Action: BindableAction {
        case path(StackActionOf<Path>)
        case binding(BindingAction<State>)
        case countryResidence(CountryResidenceReducer.Action)
        case continueButtonTapped
        
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.countryResidenceState, action: \.countryResidence) {
            CountryResidenceReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .path(_):
                return .none
            case .continueButtonTapped:
                return .none
            case .countryResidence(.countrySelected(let country)):
                state.user?.country = country.name
                state.path.append(.personalInfo(PersonalInfoReducer.State()))
                return .none
            case .countryResidence(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

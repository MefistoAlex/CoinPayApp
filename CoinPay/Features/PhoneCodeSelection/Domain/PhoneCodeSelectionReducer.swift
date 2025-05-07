//
//  PhoneCodeSelectionReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 22.04.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PhoneCodeSelectionReducer: Equatable {
    static func == (lhs: PhoneCodeSelectionReducer, rhs: PhoneCodeSelectionReducer) -> Bool {
        lhs.id == rhs.id
    }
    
    private let id = UUID()
    
    @Dependency(\.countriesUseCase) private var countriesUseCase
    @ObservableState
    struct State: Equatable {
        var searchText = ""
        var countries: [CountrySection] = []
        var selectedCountry: Country = Country.shared
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case getAllCountries
        case searchCountries(String)
        case countrySelected(Country)
        case countriesReceived([CountrySection])
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.searchText):
                let search = state.searchText
                return .send(.searchCountries(search))
            case .binding(_):
                return .none
            case .getAllCountries:
                return .run { send in
                    let countriesSections = await countriesUseCase.searchSections(search: "")
                    await send(.countriesReceived(countriesSections))
                }
            case .searchCountries(let search):
                return .run { send in
                    let countriesSections = await countriesUseCase.searchSections(search: search)
                    await send(.countriesReceived(countriesSections))
                }
            case .countrySelected:
                return .none
            case .countriesReceived(let countries):
                state.countries = countries
                return .none
            }
        }
    }
}

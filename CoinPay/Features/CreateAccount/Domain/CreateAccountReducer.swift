//
//  CreateAccountReducer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture
import FirebaseAuth

@Reducer
struct CreateAccountReducer: Equatable {
    @Dependency(\.countriesUseCase) private var countriesUseCase
    enum Constants {
        static let phoneCode = "🇺🇦 +380"
        static let stepsCount = 3
        static let currentStep = 1
        static let regEx = "^\\+\\d{12}$"
    }
    private let id = UUID()
    static func == (lhs: CreateAccountReducer, rhs: CreateAccountReducer) -> Bool {
        lhs.id == rhs.id
    }
    
    @ObservableState
    struct State: Equatable {
        @Presents var phoneCodeSelectionState:  PhoneCodeSelectionReducer.State?
        var countries: [CountrySection] = []
        var phoneCode: String = Constants.phoneCode
        var phoneNumber: String = ""
        var password: String = ""
        var isPasswordShowing = false
        var isSignUpButtonEnabled = false
        var focusedField: Field?
        var isPhoneValid = true
        var isVerificationScreenShowed = false
        enum Field: String, Hashable {
            case phoneNumber, password
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case phoneCodeSelectionAction(PresentationAction<PhoneCodeSelectionReducer.Action>)
        case getCurrentCountryPhoneCode
        case phoneCodeButtonTaped
        case phoneCodeReceived(Country)
        case backButtonTapped
        case phoneNumberDidEndEditing
        case passwordVisibilityButtonTapped
        case signUpButtonTapped
        case phoneCorrectTapped
        case phoneIncorrectTapped
        case accountCreated(phoneNumber: String, password: String)
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
            case .phoneCodeSelectionAction(.presented(.countrySelected(let country))):
                state.phoneCode = "\(country.code.getFlag()) \(country.phoneCode)"
                return .none
            case .phoneCodeSelectionAction(_):
                return .none
            case .phoneCodeButtonTaped:
                state.phoneCodeSelectionState = PhoneCodeSelectionReducer.State()
                return .none
            case .getCurrentCountryPhoneCode:
                return .run { send in
                    let country = await countriesUseCase.getCurrentCountry()
                    guard let country else { return }
                    await send(.phoneCodeReceived(country))
                }
            case .phoneCodeReceived(let country):
                state.phoneCode = "\(country.code.getFlag()) \(country.phoneCode)"
                return .none
            case .backButtonTapped:
                return .none
            case .phoneNumberDidEndEditing:
                let phoneNumber = (state.phoneCode + state.phoneNumber).dropFirst(2)
                state.isPhoneValid = isValidPhoneNumber(String(phoneNumber))
                return .none
            case .passwordVisibilityButtonTapped:
                state.isPasswordShowing.toggle()
                return .none
            case .signUpButtonTapped:
                state.isVerificationScreenShowed = true
                return .none
            case .phoneCorrectTapped:
                state.isVerificationScreenShowed = false
                return .send(.accountCreated(phoneNumber: String(state.phoneCode.dropFirst(2) + state.phoneNumber), password: state.password))
            case .phoneIncorrectTapped:
                state.isVerificationScreenShowed = false
               return .none
            case .accountCreated:
                return .none
            }
        }
        .ifLet(\.$phoneCodeSelectionState, action: \.phoneCodeSelectionAction) {
            PhoneCodeSelectionReducer()
        }
    }
    
    private func getSignUpButtonEnable(state: State) -> Bool {
        return !state.phoneNumber.isEmpty && !state.password.isEmpty && state.isPhoneValid
    }
    
    private func isValidPhoneNumber(_ value: String) -> Bool {
        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", Constants.regEx)
        return phoneCheck.evaluate(with: value) && value.count == 13
    }
}

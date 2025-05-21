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
    enum Constants {
        static let otpLength = 6
        static let stepsCount = 3
        static let currentStep = 2
        static let timerCountDown = 60
    }
    
    static func == (lhs: ConfirmPhoneReducer, rhs: ConfirmPhoneReducer) -> Bool {
        return true
    }
    
    @Dependency(\.otpVerificationUseCase) private var otpVerificationUseCase
    
    @ObservableState
    struct State: Equatable {
        var alert: AlertState<Never>?
        var phoneNumber: String = ""
        var password: String = ""
        var sentCode: String = ""
        var enteredCode: String = ""
        var countDown: Int = Constants.timerCountDown
        var confirmationCode = false
        var isVerifyNumberButtonEnabled = false
        var isVerifyErrorShowed = false
        var isTimerStarted = false
        
        init(phoneNumber: String = "", password: String = "") {
            self.phoneNumber = phoneNumber
            self.password = password
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case sendOTP
        case receivedOTP(String)
        case resendButtonTapped
        case verifyButtonTapped
        case backButtonTapped
        case verifyOTP
        case showErrorAlert(NetworkDataError)
        case countDownTimerTicked
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .resendButtonTapped:
                state.isTimerStarted = true
                return .send(.sendOTP)
            case .verifyButtonTapped:
                state.isVerifyErrorShowed = state.enteredCode != state.sentCode
                return .none
            case .sendOTP:
                let publisher = otpVerificationUseCase.sendOTP(phoneNumber: state.phoneNumber)
                return .run { send in
                    do {
                        for try await code in publisher.values {
                              await send(.receivedOTP(code))
                        }
                    } catch {
                        guard let error = error as? NetworkDataError else { return }
                        await send(.showErrorAlert(error))
                    }
                   
                }
            case .receivedOTP(let code):
                state.sentCode = code
                return .none
            case .backButtonTapped:
                return .none
            case .verifyOTP:
                
                state.isVerifyNumberButtonEnabled = state.enteredCode.count == Constants.otpLength
                return .none
            case .showErrorAlert(let error):
                state.alert = AlertState(title: {
                    TextState(L10n.Error.title)
                }, message: {
                    TextState(error.message)
                })
                return .none
            case .countDownTimerTicked:
                if state.isTimerStarted {
                    if state.countDown > 0 {
                        state.countDown -= 1
                    } else {
                        state.isTimerStarted = false
                        state.countDown = Constants.timerCountDown
                    }
                }
                return .none
            }
        }
    }
}

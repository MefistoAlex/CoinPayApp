//
//  ConfirmPhoneView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

struct ConfirmPhoneView: View {
    @Bindable var store: StoreOf<ConfirmPhoneReducer>
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            ProgressBarView(step: ConfirmPhoneReducer.Constants.currentStep,
                            totalSteps: ConfirmPhoneReducer.Constants.stepsCount)
            
            VStack {
                Text(L10n.Authorisation.ConfirmPhone.title)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
                
                Text("\(L10n.Authorisation.ConfirmPhone.subtitle) \(store.phoneNumber)")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 22)
                
                VStack {
                    OTPFieldView(numberOfFields: 6, otp: $store.enteredCode)
                        .onChange(of: store.enteredCode, { oldValue, newValue in
                            if newValue.count == 6 {
                                UIApplication.shared.endEditing()
                                store.send(.verifyOTP)
                            }
                        })
                    
                    if store.isVerifyErrorShowed {
                        Text(L10n.Authorisation.ConfirmPhone.codeMissmatch)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }
                }
                .padding(.bottom, 22)
                
                HStack {
                    
                    if store.isTimerStarted {
                        Text(L10n.Authorisation.ConfirmPhone.canResend + " \(store.countDown)")
                            .font(.subheadline)
                            .foregroundColor(.blue100)
                            .padding(.leading, 8)
                    } else {
                        Text(L10n.Authorisation.ConfirmPhone.didntGetCode)
                            .font(.subheadline)
                        
                        Button(action: {
                            store.send(.resendButtonTapped)
                        }) {
                            Text(L10n.Button.resend)
                                .foregroundColor(.blue100)
                                .font(.subheadline)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    UIApplication.shared.endEditing()
                    store.send(.verifyButtonTapped)
                }) {
                    Text(L10n.Button.verify)
                        .font(.title3)
                        .fontWeight(.regular)
                        .frame(width: UIScreen.main.bounds.width - 32,  height: 56)
                }
                .buttonStyle(ScaledButtonStylePrimary())
                .disabled(!store.isVerifyNumberButtonEnabled)
            }
            .padding(.horizontal, 16)
        }
        .onReceive(timer, perform: { _ in
            store.send(.countDownTimerTicked)
        })
        .alert($store.alert)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { self.store.send(.backButtonTapped) }) {
                    Image(.backArrow)
                        .foregroundStyle(.secondary)
                        .offset(x: -8)
                }
            }
        }
        .onAppear {
            store.send(.sendOTP)
        }
    }
}

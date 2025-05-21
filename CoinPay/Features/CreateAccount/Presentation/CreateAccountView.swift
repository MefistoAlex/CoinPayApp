//
//  CreateAccountView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

struct CreateAccountView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @Bindable private var store: StoreOf<CreateAccountReducer>
    @FocusState private var focusedField: CreateAccountReducer.State.Field?
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ProgressBarView(step: CreateAccountReducer.Constants.currentStep,
                            totalSteps: CreateAccountReducer.Constants.stepsCount)
            
            VStack {
                Text(L10n.Authorisation.CreateAccount.title)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
                Text(L10n.Authorisation.CreateAccount.subtitle)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 22)
                
                InputFieldsView(store: store)
                
                Spacer()
                
                Button(action: {
                    UIApplication.shared.endEditing()
                    store.send(.signUpButtonTapped)
                }) {
                    Text(L10n.Button.signUp)
                        .font(.title3)
                        .fontWeight(.regular)
                        .frame(width: UIScreen.main.bounds.width - 32,  height: 56)
                }
                .buttonStyle(ScaledButtonStylePrimary())
                .disabled(!store.isSignUpButtonEnabled)
            }
            .padding(.horizontal, 16)
        }
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
        .blur(radius: store.isVerificationScreenShowed ? 2 : 0)
        .overlay(content: {
            if store.isVerificationScreenShowed {
                PhoneVerificationRequestView(store: store)
            }
        })
        .padding(.horizontal, 16)
        .padding(.bottom, 22)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear(perform: {
            store.send(.getCurrentCountryPhoneCode)
        })
    }
}

// MARK: - InputFieldsView

struct InputFieldsView: View {
    @Bindable private var store: StoreOf<CreateAccountReducer>
    @FocusState private var focusedField: CreateAccountReducer.State.Field?
    
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack() {
            Text(L10n.Authorisation.CreateAccount.phone)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                HStack(alignment: .top) {
                    Button {
                        store.send(.phoneCodeButtonTaped)
                    } label: {
                        Text (store.phoneCode)
                            .padding(12)
                            .cornerRadius(8)
                            .foregroundStyle(.primaryText)
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 1)
                    }
                    
                    TextField(L10n.Authorisation.CreateAccount.mobileNumber, text: $store.phoneNumber, onEditingChanged: { endEdit in
                        if !endEdit {
                            store.send(.phoneNumberDidEndEditing)
                        }
                    })
                    .keyboardType(.numberPad)
                    .padding(12)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 1)
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button(L10n.Button.done) {
                                UIApplication.shared.endEditing()
                            }
                        }
                    }
                }
                
                if !store.isPhoneValid {
                    Text(L10n.Authorisation.CreateAccount.wrongPhoneNumber)
                        .foregroundStyle(Color.red)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .animation(.easeInOut, value: store.isPhoneValid)
            .padding(.bottom, 14)
            
            Text(L10n.Authorisation.CreateAccount.password)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(store.isPasswordShowing ? .lockOpen: .lock)
                    .accentColor(.border)
                    .padding(.horizontal, 8)
                
                if store.isPasswordShowing {
                    TextField(text: $store.password) {
                        Text(L10n.Authorisation.CreateAccount.enterPassword)
                            .foregroundStyle(Color.border)
                            .focused($focusedField, equals: .password)
                    }
                } else {
                    SecureField(text: $store.password) {
                        Text(L10n.Authorisation.CreateAccount.enterPassword)
                            .foregroundStyle(Color.border)
                            .focused($focusedField, equals: .password)
                    }
                }
                
                Button {
                    store.send(.passwordVisibilityButtonTapped)
                } label: {
                    Image(store.isPasswordShowing ? .eye : .eyeSlash)
                        .accentColor(.border)
                        .padding(.horizontal, 8)
                }
            }
            .padding(12)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.border, lineWidth: 1)
            }
        }
        .padding(4)
        .sheet(item:  $store.scope(state: \.phoneCodeSelectionState, action: \.phoneCodeSelectionAction) ) { store in
            PhoneCodeSelectionView(store: store)
        }
    }
}

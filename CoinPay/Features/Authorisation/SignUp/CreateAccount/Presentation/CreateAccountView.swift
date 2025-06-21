//
//  CreateAccountView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture
import Loco

struct CreateAccountView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @Bindable private var store: StoreOf<CreateAccountReducer>
//    @FocusState private var focusedField: CreateAccountReducer.State.Field?
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    
    var body: some View {
//        VStack(alignment: .center) {
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
//                .padding(.horizontal, 16)
                .buttonStyle(ScaledButtonStylePrimary())
                .disabled(!store.isSignUpButtonEnabled)
            }
            .padding(.horizontal, 16)
//        }
//        .padding(.horizontal, 16)
        .background(content: {
            DarkGradient()
                .ignoresSafeArea()
        })
        .alert($store.alert)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { self.store.send(.backButtonTapped) }) {
                    Image(.backArrow)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .blur(radius: store.isVerificationScreenShowed ? 2 : 0)
        .overlay(content: {
            if store.isVerificationScreenShowed {
                PhoneVerificationRequestView(store: store)
            }
        })
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
        VStack(alignment: .leading) {
            Text(L10n.Authorisation.CreateAccount.phone)
                .padding(.bottom, 8)
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
                    .glassEffect(.regular.interactive())
                    
                    TextField(L10n.Authorisation.CreateAccount.mobileNumber, text: $store.phoneNumber, onEditingChanged: { endEdit in
                        if !endEdit {
                            store.send(.phoneNumberDidEndEditing)
                        }
                    })
                    .keyboardType(.numberPad)
                    .padding(12)
                    .glassEffect()
                }
                
                if !store.isPhoneValid {
                    Text(L10n.Authorisation.CreateAccount.wrongPhoneNumber)
                        .foregroundStyle(Color.red)
                        .padding(.leading, 8)
                }
            }
            .animation(.easeInOut, value: store.isPhoneValid)
            .padding(.bottom, 14)
            
            Text(L10n.Authorisation.CreateAccount.password)
                .padding(.bottom, 8)
            
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
            .glassEffect()
        }
        .padding(4)
        .sheet(item:  $store.scope(state: \.phoneCodeSelectionState, action: \.phoneCodeSelectionAction) ) { store in
            PhoneCodeSelectionView(store: store)
        }
    }
}

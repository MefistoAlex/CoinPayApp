//
//  CreateAccountView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

struct CreateAccountView: View {
    @Bindable private var store: StoreOf<CreateAccountReducer>
    @FocusState private var focusedField: CreateAccountReducer.State.Field?
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ProgressBarView(step: CreateAccountReducer.Constants.currentStep,
                            totalSteps: CreateAccountReducer.Constants.stepsCount)
            
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
            
            Button(action: { store.send(.signUpButtonTapped) }) {
                Text(L10n.Button.signUp)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(width: UIScreen.main.bounds.width - 32,  height: 56)
            }
            .buttonStyle(ScaledButtonStylePrimary())
            .disabled(!store.isSignUpButtonEnabled)
            .padding(.horizontal, 16)
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { self.store.send(.backButtonTapped) }) {
                    Image(.backArrow)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 22)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
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
                        
                    } label: {
                        Text (store.phoneCode)
                            .padding(12)
                            .cornerRadius(8)
                            .foregroundStyle(Color.white)
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
    }
}

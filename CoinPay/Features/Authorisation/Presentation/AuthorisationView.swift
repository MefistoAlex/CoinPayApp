//
//  AuthorisationView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import SwiftUI
import ComposableArchitecture

struct AuthorisationView: View {
    @Bindable var store: StoreOf<AuthorisationReducer>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Image(.authorisation)
                        .frame(height: 260)
                        .padding(.bottom, 64)
                        .padding(.top, 48)
                    
                    Text(L10n.Authorisation.Signup.title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    Text(L10n.Authorisation.Signup.subtitle)
                        .foregroundStyle(.contentTertiary)
                        .multilineTextAlignment(.center)
                        .padding(16)

                    Spacer()
                    
                    Button(action: { store.send(.signUpButtonTapped) }) {
                        Text(L10n.Button.signUp)
                            .font(.title3)
                            .fontWeight(.regular)
                            .frame(width: geometry.size.width - 32,  height: 56)
                    }
                    .buttonStyle(ScaledButtonStylePrimary())
                    .padding(.horizontal, 16)
                    
                    Button(action: { store.send(.logInButtonTapped) }) {
                        Text(L10n.Button.logIn)
                            .font(.title3)
                            .fontWeight(.regular)
                            .frame(width: geometry.size.width - 32,  height: 56)
                    }
                    .buttonStyle(ScaledButtonStyleSecondary())
                    .padding(16)
                    
                    Spacer()
                    
                    Text(L10n.Authorisation.Signup.termsTitle)
                        .foregroundStyle(.contentTertiary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                   
                    HStack {
                        Button(action: { store.send(.termsButtonTapped) }) {
                            Text(L10n.Authorisation.Signup.terms)
                                .foregroundStyle(.contentAccent)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .underline()
                        }
                        
                        Text(L10n.Authorisation.Signup.and)
                            .foregroundStyle(.contentTertiary)
                        
                        Button(action: { store.send(.policyButtonTapped) }) {
                            Text(L10n.Authorisation.Signup.privacy)
                                .foregroundStyle(.contentAccent)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .underline()
                        }
                    }
                    .font(.caption)
                    .padding(.horizontal, 16)
                }
            }
            .sheet(item: $store.presentedURL) { url in
                WebView(url: url)
                    .overlay(alignment: .topTrailing) {
                        CloseButton(action: { store.presentedURL = nil })
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        } destination: { store in
            switch store.case {
            case .createAccount(let store):
                CreateAccountView(store: store)
            case .confirmPhone(let store):
                ConfirmPhoneView(store: store)
            }
        }

       
    }
}



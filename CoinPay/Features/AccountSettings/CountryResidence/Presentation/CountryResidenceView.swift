//
//  CountryResidenceView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.06.2025.
//

import SwiftUI
import ComposableArchitecture
import Loco

struct CountryResidenceView: View {
    @Bindable private var store: StoreOf<CountryResidenceReducer>
    
    init(store: StoreOf<CountryResidenceReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.AccountSettings.CountryResidency.title)
                .multilineTextAlignment(.leading)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            
            Text(L10n.AccountSettings.CountryResidency.subtitle)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 22)
                .padding(.horizontal, 16)
            
            Button {
                store.send(.countryButtonTapped)
            } label: {
                VStack {
                    let countryName = "\(store.country?.code.getFlag() ?? "") \(store.country?.name ?? "")"
                    let placeholder = L10n.Authorisation.CreateAccount.choseYourCountry
                    HStack {
                        Text(store.country != nil ? countryName : placeholder)
                        Spacer()
                        Image(.arrowDown)
                    }
                }
                .foregroundStyle(.primaryText)
                .padding(16)
            }
            .glassEffect()
            .padding(16)
            
            Spacer()
            
            Button(action: {
                store.send(.continueButtonTapped)
            }) {
                Text(L10n.Button.continue)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(width: UIScreen.main.bounds.width - 32,  height: 56)
            }
            .buttonStyle(ScaledButtonStylePrimary())
            .disabled(store.country == nil)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(content: {
            DarkGradient()
        })
        .navigationBarTitleDisplayMode(.inline)
        .customNavBarTotalSteps(CountryResidenceReducer.Constants.stepsCount)
        .customNavBarCurrentStep(CountryResidenceReducer.Constants.currentStep)
        .customNavBarBackButtonHidden(true)
        .navigationBarBackButtonHidden()
        .sheet(item:  $store.scope(state: \.countrySelectionState,
                                   action: \.countrySelectionAction) ) { store in
            PhoneCodeSelectionView(store: store)
        }
                                
    }
}

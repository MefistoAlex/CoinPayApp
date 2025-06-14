//
//  PhoneCodeSelection.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 23.04.2025.
//

import SwiftUI
import ComposableArchitecture
import CountryPicker
import Loco

struct PhoneCodeSelectionView: View {
    @Binding var store: StoreOf<PhoneCodeSelectionReducer>
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(L10n.Authorisation.CreateAccount.choseYourCountry, text: $store.searchText)
            .padding(12)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.border, lineWidth: 1)
                    .background {
                        colorScheme == .light ? Color.white : Color.clear
                    }
            }
            .overlay(alignment: .topTrailing, content: {
                HStack {
                    Image(.search)
                        .padding(12)
                        .foregroundStyle(.gray)
                }
            })
            .padding(16)
            .background {
                colorScheme == .light ? Color.listBackground : Color.clear
            }
            
//            List {
//                ForEach(store.countries, id: \.self) { section in
//                    Section(header: Text(section.title)) {
//                        ForEach(section.countries, id: \.self) { country in
//                            Button(action: {
//                                store.send(.countrySelected(country))
//                                dismiss()
//                            }) {
//                                HStack {
//                                    Text(country.code.getFlag())
//                                    Text(country.name)
//                                    Spacer()
//                                    Text(country.phoneCode)
//                                }
//                                .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                store.send(.getAllCountries)
//            }
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    
//                    Button(L10n.Button.done) {
//                        UIApplication.shared.endEditing()
//                    }
//                }
//            }
        }
    }
}

//
//  OnboardingView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI
import ComposableArchitecture
import Loco

struct OnboardingView: View {
    @Bindable var store: StoreOf<OnboardingReducer>
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TabView(selection: $store.selectedImageIndex) {
                    ForEach(0..<store.advantages.count, id: \.self) { index in
                        ZStack(alignment: .topLeading) {
                            Image(store.advantages[index].image)
                                .tag(index)
                        }
                    }
                }
                .frame(height: 350)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .padding(.top, 48)
                
                HStack {
                    ForEach(0..<store.advantages.count, id: \.self) { index in
                        Capsule()
                            .fill($store.selectedImageIndex.wrappedValue == index ? Color.ultramarine : .unactive)
                            .frame(width: $store.selectedImageIndex.wrappedValue == index ? 16 : 37, height: 8)
                            .onTapGesture {
                                store.selectedImageIndex = index
                            }
                            .glassEffect()
                    }
                }
                .padding(.bottom, 8)
                
                Spacer()
                
                Text(store.advantages[store.selectedImageIndex].title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .semibold, design: .default))
                    .fontWeight(.bold)
                    
                    .frame(maxWidth: .infinity)
                    .padding()
                    .glassEffect(.regular, in: .rect(cornerRadius: 16.0))
                    .padding(.horizontal, 16)
              
                Spacer()
                
                Button(action: {
                   store.send(.nextButtonTapped)
                }) {
                    Text(L10n.Button.next)
                        .font(.title3)
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                }
                .buttonStyle(ScaledButtonStylePrimary())
                .background {
                    Color.blue.clipShape(Capsule())
                }
                .padding(16)
            }
            .background {
                DarkGradient()
            }
        }
    }
}

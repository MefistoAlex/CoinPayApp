//
//  PhoneVerificationRequestView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 08.05.2025.
//

import SwiftUI
import ComposableArchitecture
import Loco


struct PhoneVerificationRequestView: View {
    @Bindable private var store: StoreOf<CreateAccountReducer>
    @State var value = 0.0
    
    init(store: StoreOf<CreateAccountReducer>) {
        self.store = store
    }
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        
        VStack(alignment: .center) {
            Image(.phoneVerification)
                .frame(width: 150, height: 150)
                .padding(.top, 60)
            
            Text(L10n.Authorisation.CreateAccount.phoneVerificationTitle)
                .font(.title.weight(.semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            HStack {
                Text(L10n.Authorisation.CreateAccount.phoneVerificationSubtitle)
                
                Text(store.phoneCode.dropFirst(2) + store.phoneNumber)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
           
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                store.send(.phoneCorrectTapped)
            }) {
                Text(L10n.Button.yes)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(width: UIScreen.main.bounds.width - 92,  height: 56)
            }
            .buttonStyle(ScaledButtonStylePrimary())
            .padding(.horizontal, 16)
            
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                store.send(.phoneIncorrectTapped)
            }) {
                Text(L10n.Button.no)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(width: UIScreen.main.bounds.width - 92,  height: 56)
            }
            .buttonStyle(ScaledButtonStyleSecondary())
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
            
        }
        .background{
            Color.neutralGray
                .ignoresSafeArea()
        }
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        
        .shadow(radius: 3)
    }
}

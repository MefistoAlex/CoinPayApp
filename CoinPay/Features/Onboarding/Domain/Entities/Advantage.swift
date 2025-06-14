//
//  Advantage.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI
import Loco

enum Advantages: CaseIterable {
    case trust
    case sendMoneyAbroad
    case receiveMoney
    
    var image: ImageResource {
        switch self {
        case .trust:
            return .trust
        case .receiveMoney:
            return .receiveMoney
        case .sendMoneyAbroad:
            return .sendMoneyAbroad
        }
    }
    
    var title: String {
        switch self {
        case .trust:
            return L10n.Onboarding.title1
        case .receiveMoney:
            return L10n.Onboarding.title2
        case .sendMoneyAbroad:
            return L10n.Onboarding.title3
        }
    }
}

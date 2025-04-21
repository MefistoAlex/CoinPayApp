//
//  UIApp.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

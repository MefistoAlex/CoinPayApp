//
//  URL+Extension.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 28.03.2025.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String {
        self.absoluteString
    }
}


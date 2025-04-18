//
//  String+Extension.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation
import UIKit

public extension String {
    
    func getFlag() -> String {
        unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}

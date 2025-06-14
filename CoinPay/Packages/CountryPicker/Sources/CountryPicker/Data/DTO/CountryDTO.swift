//
//  CountryDTO.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation
public struct CountryDTO: Decodable {
    let name: String
    let phoneCode: String
    let code: String
    let citisenship: String
    
    enum CodingKeys: String, CodingKey {
        case name = "en_short_name"
        case phoneCode = "num_code"
        case code = "alpha_2_code"
        case citisenship = "nationality"
    }
    
    private enum Constant {
        static var plusSymbol: String { "+" }
    }
    
    public func toDomain() -> Country {
            Country(name: name,
                    phoneCode: Constant.plusSymbol + phoneCode,
                    code: code,
                    citisenship: citisenship)
    }
}

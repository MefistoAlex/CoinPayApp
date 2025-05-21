//
//  OTPMesageResponse.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.05.2025.
//

public struct OTPMesageResponse: Codable {
    let sent: String
    let message: String
    let id: Int
}

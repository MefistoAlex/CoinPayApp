//
//  OTPVerificationRepository.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.05.2025.
//

import Combine

public protocol IOTPVerificationRepository {
    func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError>
}

final class OTPVerificationRepository: IOTPVerificationRepository {
   
    let dataSource: IOTPVerificationDataSource
    
    init(dataSource: IOTPVerificationDataSource) {
        self.dataSource = dataSource
    }
    
    func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError> {
        dataSource.sendOTP(phoneNumber: phoneNumber)
    } 
}

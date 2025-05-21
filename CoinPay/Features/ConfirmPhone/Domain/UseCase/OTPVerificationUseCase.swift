//
//  OTPVerificationUseCase.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.05.2025.
//

import Combine

public protocol IOTPVerificationUseCase {
    func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError>
}

public class OTPVerificationUseCase: IOTPVerificationUseCase {
    let otpVerificationRepository: IOTPVerificationRepository
    
    public init(otpVerificationRepository: IOTPVerificationRepository) {
        self.otpVerificationRepository = otpVerificationRepository
    }
    
    public func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError> {
        otpVerificationRepository.sendOTP(phoneNumber: phoneNumber)
    }
}

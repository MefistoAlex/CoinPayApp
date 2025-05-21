//
//  OTPVerificationDataSource.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 11.05.2025.
//

import Foundation
import Alamofire
import Combine

public protocol IOTPVerificationDataSource {
    func generateOTP(length: Int) -> String
    func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError>
}

final public class OTPVerificationDataSource: IOTPVerificationDataSource {
    enum Constants {
        static let otpLength = 6
    }
    let network: INetworkDataService
    
    public init(network: INetworkDataService) {
        self.network = network
    }
    
    public func generateOTP(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    public func sendOTP(phoneNumber: String) -> AnyPublisher<String, NetworkDataError> {
        let otp = generateOTP(length: Constants.otpLength)
        let endpoint = Endpoint<OTPMesageResponse>(path: "https://api.ultramsg.com/instance118898/messages/chat",
                                        method: .post,
                                        headerParameters: ["Content-Type" : "application/json"],
                                        bodyParameters: [
                                            "token": "sh4jjtzolnn4qp2u",
                                            "to": "+380632414954",
                                            "body": "Your verification code is \(otp)"])
        
        return network.request(endpoint: endpoint)
            .map { _ in
                otp
            }
            .eraseToAnyPublisher()
    }
}

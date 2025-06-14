//
//  User.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 02.06.2025.
//

import Foundation
import DataPersistance

public struct User: Equatable, Identifiable {
    public var id: String { phoneNumber }
    public var phoneNumber: String
    public var password: String
    public var email: String?
    public var country: String?
    public var firstName: String?
    public var lastName: String?
    public var dateOfBirth: Date?
    public var address: String?
    public var city: String?
    public var postalCode: String?
    
    
    init(phoneNumber: String, password: String) {
        self.phoneNumber = phoneNumber
        self.password = password
    }
    
    func toModel() -> UserModel {
        let userModel = UserModel(phoneNumber: phoneNumber, password: password)
        userModel.email = email
        userModel.counry = country
        userModel.firstName = firstName
        userModel.lastName = lastName
        userModel.dateOfBirth = dateOfBirth
        userModel.address = address
        userModel.city = city
        userModel.postalCode = postalCode
        return userModel
    }
}

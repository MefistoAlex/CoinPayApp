//
//  UserModel+Extension.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 15.06.2025.
//

import DataPersistance

extension UserModel {
    func toDomain() -> User {
        return User(phoneNumber: phoneNumber, password: password)
    }
}

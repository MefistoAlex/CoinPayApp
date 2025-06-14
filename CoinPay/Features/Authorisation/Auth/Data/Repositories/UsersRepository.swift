//
//  UsersRepository.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 03.06.2025.
//

import Foundation
import Combine
import DataPersistance

public protocol IUsersRepository {
    func fetchAll() -> AnyPublisher<[UserModel], Error>
    func fetchUser(by phoneNumber: String) -> AnyPublisher<[UserModel], Error>
    func addUser(phoneNumber: String, password: String) -> AnyPublisher<UserModel, Error>
    func deleteUser(_ user: UserModel) -> AnyPublisher<Void, Error>
}

public final class UsersRepository: IUsersRepository {
    
    private var usersDataSource: IUsersDataSource
    
    public init(usersDataSource: IUsersDataSource) {
        self.usersDataSource = usersDataSource
    }
    
    public func fetchAll() -> AnyPublisher<[UserModel], Error> {
        return usersDataSource.fetchAll()
    }
    
    public func fetchUser(by phoneNumber: String) -> AnyPublisher<[UserModel], Error> {
        return usersDataSource.fetchUser(by: phoneNumber)
    }
    
    public func addUser(phoneNumber: String, password: String) -> AnyPublisher<UserModel, Error> {
        return usersDataSource.addUser(phoneNumber: phoneNumber, password: password)
    }
    
    public func deleteUser(_ user: UserModel) -> AnyPublisher<Void, Error> {
        return usersDataSource.deleteUser(user)
    }
}

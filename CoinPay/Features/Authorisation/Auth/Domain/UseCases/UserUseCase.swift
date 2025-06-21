//
//  UserUseCase.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 03.06.2025.
//

import Foundation
import Combine
import ComposableArchitecture
import DataPersistance

public protocol IUsersUseCase {
    func fetchAll() -> AnyPublisher<[User], Error>
    func fetchUser(by phoneNumber: String) -> AnyPublisher<User?, Error>
    func addUser(phoneNumber: String, password: String) -> AnyPublisher<User, Error>
    func updateUser(_ user: User) -> AnyPublisher<User, Error>
    func deleteUser(_ user: User) -> AnyPublisher<Void, Error>
    func isUserExists(phoneNumber: String) -> AnyPublisher<Bool, Error>
}

public final class UsersUseCase: IUsersUseCase {
    
    private var usersRepository: IUsersRepository
    
    public init(usersRepository: IUsersRepository) {
        self.usersRepository = usersRepository
    }
    
    public func fetchAll() -> AnyPublisher<[User], Error> {
        return usersRepository.fetchAll()
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
    
    public func fetchUser(by phoneNumber: String) -> AnyPublisher<User?, Error> {
        return usersRepository.fetchUser(by: phoneNumber)
            .map { $0.first?.toDomain() }
            .eraseToAnyPublisher()
    }
    
    public func addUser(phoneNumber: String, password: String) -> AnyPublisher<User, Error> {
        return usersRepository.addUser(phoneNumber: phoneNumber, password: password)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    public func updateUser(_ user: User) -> AnyPublisher<User, any Error> {
        let userModel = user.toModel()
        return usersRepository.updateUser(userModel)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    public func deleteUser(_ user: User) -> AnyPublisher<Void, Error> {
        let userModel = UserModel(phoneNumber: user.phoneNumber, password: user.password)
        return usersRepository.deleteUser(userModel)
    }
    
    public func isUserExists(phoneNumber: String) -> AnyPublisher<Bool, any Error> {
        usersRepository.fetchUser(by: phoneNumber)
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
}

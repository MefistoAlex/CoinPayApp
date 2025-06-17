//
//  UsersDataSource.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 01.06.2025.
//

import SwiftData
import Combine
import ComposableArchitecture
import Foundation
import DataPersistance
import Loco

public enum UserError: Error {
    case add
    case delete
    
    var localizedDescription: String {
        switch self {
        case .add:
            return L10n.Error.userExist
        case .delete:
            return L10n.Error.userDeletionFailed
        }
    }
}

public protocol IUsersDataSource {
    func fetchAll() -> AnyPublisher<[UserModel], Error>
    func fetchUser(by phoneNumber: String) -> AnyPublisher<[UserModel], Error>
    func addUser(phoneNumber: String, password: String) -> AnyPublisher<UserModel, Error>
    func deleteUser(_ user: UserModel) -> AnyPublisher<Void, Error>
    func isUserExist(phoneNumber: String) -> AnyPublisher<Bool, Error>
    func clearAllUsers() -> AnyPublisher<Void, Error>
}

struct UsersDataSource: IUsersDataSource {
    @Dependency(\.databaseService.context) private  var context
    
    func fetchAll() -> AnyPublisher<[UserModel], Error> {
        do {
            let userContext = try context()
            let descriptor = FetchDescriptor<UserModel>()
            let users: [UserModel] = try userContext.fetch(descriptor)
            return Just(users)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchUser(by phoneNumber: String) -> AnyPublisher<[UserModel], any Error> {
        do {
            let userContext = try context()
            
            let userPredicate = #Predicate<UserModel> { user in
                user.phoneNumber == phoneNumber
            }
            
            let fetchDescriptor = FetchDescriptor<UserModel>(predicate: userPredicate)
            let users: [UserModel] = try userContext.fetch(fetchDescriptor)
          
            return Just(users)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func addUser(phoneNumber: String, password: String) -> AnyPublisher<UserModel, Error> {
        let user = UserModel(phoneNumber: phoneNumber, password: password)
        
        do {
            let userContext = try context()
            let userPredicate = #Predicate<UserModel> { user in
                user.phoneNumber == phoneNumber
            }
            let fetch = FetchDescriptor<UserModel>(predicate: userPredicate)
            let users: [UserModel] = try userContext.fetch(fetch)
            
            guard users.isEmpty else { throw UserError.add }
            userContext.insert(user)
            
            try userContext.save()
            return Just(user)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func deleteUser(_ user: UserModel) -> AnyPublisher<Void, Error> {
        do {
            let userContext = try context()

            userContext.delete(user)
            
            try userContext.save()
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: UserError.delete)
                .eraseToAnyPublisher()
        }
    }
    
    func isUserExist(phoneNumber: String) -> AnyPublisher<Bool, any Error> {
        do {
            let userContext = try context()
            let userPredicate = #Predicate<UserModel> { user in
                user.phoneNumber == phoneNumber
            }
            let fetch = FetchDescriptor<UserModel>(predicate: userPredicate)
            let users: [UserModel] = try userContext.fetch(fetch)
          
            return Just(!users.isEmpty)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func clearAllUsers() -> AnyPublisher<Void, any Error> {
        do {
            let userContext: ModelContext = try context()
            try userContext.delete(model: UserModel.self)
            try userContext.save()
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
    }
}

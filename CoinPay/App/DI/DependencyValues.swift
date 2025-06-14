//
//  DependencyValues.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//

import ComposableArchitecture
import SwiftData
import CountryPicker
import NetworkService
import DataPersistance

//MARK: - DataBase

extension DependencyValues {
    var dataBaseProvider: SwiftDataModelConfigurationProvider {
        get { self[DataBaseProviderKey.self] }
    }
}

extension DependencyValues {
    public var database: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}
// Global Swift Data Dependency
extension DependencyValues {
    var databaseService: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

//MARK: - NetworkService

extension DependencyValues {
    public var networkDataService: INetworkDataService {
        get { self[NetworkDataServiceKey.self] }
    }
}

// MARK: - DataSources

extension DependencyValues {
    public var countriesDataSource: ICountriesDataSource {
        get { self[CountriesDataSourceKey.self] }
    }
}

extension DependencyValues {
    public var otpVerificationDataSource: IOTPVerificationDataSource {
        get { self[OTPVerificationDataSourceKey.self] }
    }
}

extension DependencyValues {
    public var usersDataSource: IUsersDataSource {
        get { self[UsersDataSourceKey.self] }
    }
}

// MARK: - Repositories

extension DependencyValues {
    public var countriesRepository: ICountriesRepository {
        get { self[CountriesRepositoryKey.self] }
    }
}

extension DependencyValues {
    public var otpVerificationRepository: IOTPVerificationRepository {
        get { self[OTPVerificationRepositoryKey.self] }
    }
}

extension DependencyValues {
    public var usersRepository: IUsersRepository {
        get { self[UsersRepositoryKey.self] }
    }
}

// MARK: - UseCases

extension DependencyValues {
    public var countriesUseCase: ICountriesPickerUseCase {
        get { self[CountriesUseCase.self] }
    }
}

extension DependencyValues {
    public var otpVerificationUseCase: IOTPVerificationUseCase {
        get { self[OTPVerificationUseCaseKey.self] }
    }
}

extension DependencyValues {
    public var usersUseCase: IUsersUseCase {
        get { self[UsersUseCaseKey.self] }
    }
}

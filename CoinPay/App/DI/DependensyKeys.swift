//
//  DependensyKeys.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//
import SwiftUI
import ComposableArchitecture
import SwiftData
import CountryPicker
import NetworkService
import DataPersistance
// - MARK: DataBase

extension Database: @retroactive DependencyKey {
    
    public static let liveValue = {
        @Dependency(\.dataBaseProvider) var dataBaseProvider
        return Database(
            context: {
                {
                    let container = dataBaseProvider.container
                    let context = ModelContext(container)
                    return context
                }()
            }
        )
    }()
}

enum DataBaseProviderKey: DependencyKey {
    static var liveValue: SwiftDataModelConfigurationProvider = SwiftDataModelConfigurationProvider()
}

// - MARK: NetworkService

enum NetworkDataServiceKey: DependencyKey {
    static var liveValue: INetworkDataService = NetworkDataService()
}

// - MARK: DataSources

enum CountriesDataSourceKey: DependencyKey {
    static var liveValue = CountriesDataSource()
}

enum OTPVerificationDataSourceKey: DependencyKey {
    static var liveValue = {
        @Dependency(\.networkDataService) var networkDataService
        return OTPVerificationDataSource(network: networkDataService)
    }()
}

enum UsersDataSourceKey: DependencyKey {
    public static let liveValue: IUsersDataSource = UsersDataSource()
}

// - MARK: Repositories

enum CountriesRepositoryKey: DependencyKey {
    static var liveValue = {
        @Dependency(\.countriesDataSource) var countriesDataSource
        return CountriesRepository(countryDataSource: countriesDataSource)
    }()
}

enum OTPVerificationRepositoryKey: DependencyKey {
    static var liveValue: OTPVerificationRepository = {
        @Dependency(\.otpVerificationDataSource) var dataSource
        return OTPVerificationRepository(dataSource: dataSource)
    }()
}

enum UsersRepositoryKey: DependencyKey {
    public static var liveValue: IUsersRepository = {
        @Dependency(\.usersDataSource) var usersDataSource
        return UsersRepository(usersDataSource: usersDataSource)
    }()
}

// - MARK: UseCases

enum CountriesUseCase: DependencyKey {
    static var liveValue = {
        @Dependency(\.countriesRepository) var countriesRepository
        return CountriesPickerUseCase(countriesRepository: countriesRepository)
    }()
}

enum OTPVerificationUseCaseKey: DependencyKey {
    static var liveValue = {
        @Dependency(\.otpVerificationRepository) var otpVerificationRepository
        return OTPVerificationUseCase(otpVerificationRepository: otpVerificationRepository)
    }()
}

enum UsersUseCaseKey: DependencyKey {
    static var liveValue = {
        @Dependency(\.usersRepository) var usersRepository
        return UsersUseCase(usersRepository: usersRepository)
    }()
}


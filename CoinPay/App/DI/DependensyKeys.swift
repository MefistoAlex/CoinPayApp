//
//  DependensyKeys.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//
import SwiftUI
import ComposableArchitecture

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

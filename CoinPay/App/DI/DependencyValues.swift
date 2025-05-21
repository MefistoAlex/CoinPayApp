//
//  DependencyValues.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//

import ComposableArchitecture

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

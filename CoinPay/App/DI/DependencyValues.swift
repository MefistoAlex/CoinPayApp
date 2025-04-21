//
//  DependencyValues.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//

import ComposableArchitecture

// MARK: - DataSources

extension DependencyValues {
    public var countriesDataSource: ICountriesDataSource {
        get { self[CountriesDataSourceKey.self] }
    }
}

// MARK: - Repositories

extension DependencyValues {
    public var countriesRepository: ICountriesRepository {
        get { self[CountriesRepositoryKey.self] }
    }
}

// MARK: - UseCases

extension DependencyValues {
    public var countriesUseCase: ICountriesPickerUseCase {
        get { self[CountriesUseCase.self] }
    }
}

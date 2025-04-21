//
//  DependensyKeys.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 20.04.2025.
//
import SwiftUI
import ComposableArchitecture

// - MARK: DataSources

enum CountriesDataSourceKey: DependencyKey {
    static var liveValue = CountriesDataSource()
}

// - MARK: Repositories

enum CountriesRepositoryKey: DependencyKey {
    static var liveValue = {
        @Dependency(\.countriesDataSource) var countriesDataSource
        return CountriesRepository(countryDataSource: countriesDataSource)
    }()
}

// - MARK: UseCases

enum CountriesUseCase: DependencyKey {
    static var liveValue = {
        @Dependency(\.countriesRepository) var countriesRepository
        return CountriesPickerUseCase(countriesRepository: countriesRepository)
    }()
}

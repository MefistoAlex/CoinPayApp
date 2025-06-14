//
//  Untitled.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation

public protocol ICountriesRepository: Sendable {
    func getAllCountries() -> [Country]
}

public final class CountriesRepository: ICountriesRepository, Sendable {
    let countryDataSource: ICountriesDataSource
    
    public init(countryDataSource: ICountriesDataSource) {
        self.countryDataSource = countryDataSource
    }
    
    public func getAllCountries() -> [Country] {
        countryDataSource.getAllCountries().map { $0.toDomain() }
    }
}

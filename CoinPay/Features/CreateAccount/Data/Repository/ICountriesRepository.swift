//
//  Untitled.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation

protocol ICountriesRepository {
    func getAllCountries() -> [Country]
}

final class CountriesRepository: ICountriesRepository {
    let countryDataSource: ICountriesDataSource
    
    init(countryDataSource: ICountriesDataSource) {
        self.countryDataSource = countryDataSource
    }
    
    func getAllCountries() -> [Country] {
        countryDataSource.getAllCountries().map { $0.toDomain() }
    }
}

//
//  ICountriesDataSource.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation

public protocol ICountriesDataSource: Sendable  {
    func getAllCountries() -> [CountryDTO]
    func getCountryBy(code: String) -> CountryDTO?
}

public struct CountriesDataSource: ICountriesDataSource {
    
    public init() {
        
    }
    
    private enum Constants: String {
        case countryCodes = "CountryCodes"
        
        static var format: String { "json" }
    }
    
    private let jsonDecoder = JSONDecodeService()
    
    public func getAllCountries() -> [CountryDTO] {
        
        guard let settingsURL = Bundle.module.url(forResource: Constants.countryCodes.rawValue, withExtension: Constants.format) else { return [] }
        
        let countries: [CountryDTO]? = jsonDecoder.decode(url: settingsURL)
        
        if let countries {
            return countries
        }
        return []
    }
    
    public  func getCountryBy(code: String) -> CountryDTO? {
        getAllCountries().first { $0.code == code }
    }
    
}

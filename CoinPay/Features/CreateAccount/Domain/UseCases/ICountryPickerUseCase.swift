//
//  CountriesPickerService.swift
//
//
//  Created by Alexandr Mefisto on 02.05.2023.
//

import Foundation

private enum Constants {
    static var currentLocationCode: String { "UA" }
    static var currentLocation: Country {
        Country(name: "Ukraine", phoneCode: "+380", code: currentLocationCode, citisenship: "Ukranian")
    }
    static var countSearch: Int { 2 }
}

public protocol ICountriesPickerUseCase {
    func searchSections(search: String) async -> [CountrySection]
    func getCountryBy(code: String) -> Country?
    func getCurrentCountry() async -> Country?
}

public final class CountriesPickerUseCase: ICountriesPickerUseCase {
    
    private let locationManager: LocationManager = LocationManager.shared
    private let countriesRepository: ICountriesRepository
    private var currentCountry: Country?
    
    private lazy var allCountries = countriesRepository.getAllCountries()
    
    init(countriesRepository: ICountriesRepository) {
        self.countriesRepository = countriesRepository
    }
    
    public func getCurrentCountry() async -> Country? {
        let countryCode = await locationManager.getCountryCode()
        guard let countryCode else { return Constants.currentLocation }
        return getCountryBy(code: countryCode)
    }
    
    public func searchSections(search: String = "") async -> [CountrySection] {
        let countryCode = await locationManager.getCountryCode()
        
        var firstSection = [CountrySection]()
        var countries = [Country]()
        if search.count < Constants.countSearch {
            
            if let countryCode, let country = getCountryBy(code: countryCode)  {
                countries = allCountries.filter { $0.code != countryCode }
                firstSection.append(CountrySection(title: L10n.Authorisation.CreateAccount.yourLocation,
                                                   countries: [country]))
            } else {
                countries = allCountries
            }
            
        } else {
            countries = allCountries.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
        
        var sections = [CountrySection]()
        
        let sectionNames = countries.map { $0.name.first }.compactMap { $0 }
        let uniqueSectionNames = Array(Set(sectionNames)).sorted()
        
        uniqueSectionNames.forEach { name in
            sections.append(CountrySection(
                title: String(name),
                countries: countries.filter { $0.name.starts(with: String(name)) })
            )
        }
        
        let result = firstSection + sections
        
        return result
    }
    
    public func getCountryBy(code: String) -> Country? {
        allCountries.first { $0.code == code }
    }
    
}

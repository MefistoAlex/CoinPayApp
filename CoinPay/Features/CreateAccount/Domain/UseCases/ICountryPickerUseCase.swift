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
    func searchSections(search: String) -> [CountrySection]
    func getCountryBy(code: String) -> Country?
}

public final class CountriesPickerUseCase: ICountriesPickerUseCase {
    
    private let countriesRepository: ICountriesRepository
    
    private lazy var allCountries = countriesRepository.getAllCountries()
    
    init(countriesRepository: ICountriesRepository) {
        self.countriesRepository = countriesRepository
    }
    
    public func searchSections(search: String = "") -> [CountrySection] {
        var firstSection = [CountrySection]()
        var countries = [Country]()
        if search.count < Constants.countSearch {
            countries = allCountries.filter { $0.code != Constants.currentLocationCode }
            firstSection.append(CountrySection(title: L10n.Authorisation.CreateAccount.choseYourCountry,
                                               countries: [Constants.currentLocation]))
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

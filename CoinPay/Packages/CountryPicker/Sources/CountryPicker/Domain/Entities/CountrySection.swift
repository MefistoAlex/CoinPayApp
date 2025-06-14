//
//  CountrySection.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//
import Foundation

public final class CountrySection: Hashable {
    var id = UUID()
    
    var title: String
    var countries: [Country]
    
    init(title: String, countries: [Country]) {
        self.title = title
        self.countries = countries
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CountrySection, rhs: CountrySection) -> Bool {
        lhs.id == rhs.id
    }
}

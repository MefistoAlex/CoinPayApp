//
//  CountrySection.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//
import Foundation

public final class CountrySection: Hashable {
    public var id = UUID()
    
    public var title: String
    public var countries: [Country]
    
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

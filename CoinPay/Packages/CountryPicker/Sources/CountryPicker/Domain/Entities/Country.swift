//
//  Country.swift
//  
//
//  Created by Alexandr Mefisto on 02.05.2023.
//

import Foundation

public struct Country: Hashable, Sendable {
//    static let shared = Country(name: "Ukraine", phoneCode: "+380", code: "UA", citisenship: "Ukranian")
    public init(name: String, phoneCode: String, code: String, citisenship: String) {
        self.name = name
        self.phoneCode = phoneCode
        self.code = code
        self.citisenship = citisenship
    }
    
    public let name: String
    public let phoneCode: String
    public let code: String
    public let citisenship: String
    
    public var countryUIName: String { "\(code.getFlag()) \(name)" }
    public var citisenshipUIName: String { "\(code.getFlag()) \(citisenship)" }
}

public extension String {
    
    func getFlag() -> String {
        unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}

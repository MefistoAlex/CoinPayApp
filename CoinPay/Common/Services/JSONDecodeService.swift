//
//  Untitled.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 29.03.2025.
//

import Foundation
public final class  JSONDecodeService {
    private let decoder = JSONDecoder()
    
    public init() {
    }
    
    public func decode<T: Decodable>(url: URL) -> T? {
        let data = try? Data(contentsOf: url)
        if let data {
            do {
                let result = try decoder.decode(T.self, from: data)
                return result
            } catch {
            }
        }
        return nil
    }
    
    public func decode<T: Decodable>(from dictionary: [AnyHashable: Any]) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)")
        } catch {
            print("Unknown error: \(error)")
        }
        return nil
    }
}

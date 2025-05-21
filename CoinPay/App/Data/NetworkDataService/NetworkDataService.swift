//
//  NetworkDataService.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.05.2025.
//

import Combine
import Foundation

public enum NetworkDataError: Error {
    case invalidURL
    case httpError(Int)
    case decodingError
    case unknown(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return L10n.Error.invalidUrl
        case .httpError(let code):
            return L10n.Error.http(String(code))
        case .decodingError:
            return L10n.Error.decoding
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

public protocol INetworkDataService {
    func request<R: Decodable>(endpoint: Endpoint<R>) -> AnyPublisher<R, NetworkDataError>
}

final public class NetworkDataService: INetworkDataService {
    let jsonDecoder = JSONDecoder()
    public func request<R>(endpoint: Endpoint<R>) -> AnyPublisher<R, NetworkDataError> where R : Decodable {
        
        let url = URL(string: endpoint.path)!
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headerParameters.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: endpoint.bodyParameters)
        } catch {
            return Fail(error: NetworkDataError.decodingError).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkDataError.unknown(NSError(domain: "Invalid response", code: 0))
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkDataError.httpError(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: R.self, decoder: jsonDecoder)
            .mapError { error in
                if let apiError = error as? NetworkDataError {
                    return apiError
                } else if error is DecodingError {
                    return .decodingError
                } else {
                    return .unknown(error)
                }
            }
        
        return publisher.eraseToAnyPublisher()
    }
}

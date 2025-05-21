//
//  Endpoint.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 18.05.2025.
//


public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final public class Endpoint<R:Decodable>{
    var response: R.Type { R.self }
    
    var path: String
    var method: HTTPMethod
    var headerParameters: [String: String]
    var queryParameters: [String: Any]
    var bodyParametersEncodable: Encodable?
    var bodyParameters: [String: Any]
    
    init(path: String,
         method: HTTPMethod,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParametersEncodable: Encodable? = nil,
         bodyParameters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
    }
}

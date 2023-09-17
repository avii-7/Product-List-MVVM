//
//  APIManager.swift
//  ProductList
//
//  Created by Arun on 16/09/23.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidStatusCode
    case invalidDecoding
    case other(_ error: Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func request<T: Decodable>(
        modelType: T.Type,
        endPointType: EndPointType,
        completionHandler: @escaping Handler<T>
    ) {
        
        guard let url = endPointType.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode
            else {
                completionHandler(.failure(.invalidStatusCode))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(modelType, from: data)
                completionHandler(.success(decodedData))
            }
            catch {
                completionHandler(.failure(.other(error)))
            }
        }.resume()
    }
}

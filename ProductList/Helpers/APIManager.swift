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

typealias Handler = (Result<[Product], DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetchProducts(completioHandler: @escaping Handler) {
        
        guard let url = URL(string: Constant.API.productURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completioHandler(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode
            else {
                completioHandler(.failure(.invalidStatusCode))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completioHandler(.success(products))
            }
            catch {
                completioHandler(.failure(.other(error)))
            }
        }.resume()
    }
}

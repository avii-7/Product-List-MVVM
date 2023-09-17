//
//  EndPointType.swift
//  ProductList
//
//  Created by Arun on 17/09/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

enum EndPointItem {
    case addProduct(AddProduct)
    case products
}

extension EndPointItem : EndPointType {
    
    var body: Encodable? {
        switch self {
        case .addProduct(let addProduct):
            return addProduct
        case .products:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .addProduct:
            return ["Content-Type": "application/json"]
        case .products:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        switch self {
        case .addProduct:
            return "https://dummyjson.com/"
        case .products:
            return "https://fakestoreapi.com/"
        }
        
    }
    
    var url: URL? {
        URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
}

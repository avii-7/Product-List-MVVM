//
//  AddProduct.swift
//  ProductList
//
//  Created by Arun on 17/09/23.
//

import Foundation

struct AddProduct: Encodable {
    let title: String
}

struct AddProductResponse: Decodable {
    let id: Int
    let title: String
}

//
//  ProductViewModel.swift
//  ProductList
//
//  Created by Arun on 16/09/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: EventType) -> Void)?
    
    func fetchProducts() {
        
        guard let eventHandler else { return }
        
        eventHandler(.dataFetchingStarted)
        
        APIManager.shared.request(
            modelType: [Product].self,
            endPoint: EndPointItem.products
        ) { response in
            
            eventHandler(.dataFetchingFinished)
            
            switch response {
            case .success(let products):
                self.products = products
                eventHandler(.dataLoaded)
            case .failure(let error):
                eventHandler(.dataFetchingFailed(error))
            }
        }
    }
    
    func addProduct(product: AddProduct) {
        
        APIManager.shared.request(
            modelType: AddProductResponse.self,
            endPoint: EndPointItem.addProduct(product)
        ) {
            response in
            
            switch response {
            case .success(let response):
                print(response.id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ProductViewModel {
    enum EventType {
        case dataFetchingStarted
        case dataFetchingFinished
        case dataLoaded
        case dataFetchingFailed(Error)
        
    }
}

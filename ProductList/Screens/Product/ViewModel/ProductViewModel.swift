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
            endPointType: EndPointItem.products
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
}

extension ProductViewModel {
    enum EventType {
        case dataFetchingStarted
        case dataFetchingFinished
        case dataLoaded
        case dataFetchingFailed(Error)
        
    }
}

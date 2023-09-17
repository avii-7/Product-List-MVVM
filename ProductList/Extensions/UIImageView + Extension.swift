//
//  UIImageView + Extension.swift
//  ProductList
//
//  Created by Arun on 16/09/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

//
//  ProductTableViewCell.swift
//  ProductList
//
//  Created by Arun on 16/09/23.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    static let Identifier = String(describing: ProductTableViewCell.self)

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func OnBuyButtonClick() {
        
    }
    
    func config(model: Product) {
        titleLabel.text = model.title
        categoryLabel.text = model.category
        ratingButton.setTitle(String(model.rating.rate), for: .normal)
        descriptionLabel.text = model.description
        priceLabel.text = "$ \(String(model.price))"
        productImageView.setImage(with: model.image)
    }
}

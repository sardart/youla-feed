//
//  ProductCollectionViewCell.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: NetworkImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
    }
    
    func setup(with model: ProductCollectionViewCellInput) {
        titleLabel.attributedText = model.title
        priceLabel.attributedText = model.price
        backgroundImageView.setURL(model.imageURL)
    }
}

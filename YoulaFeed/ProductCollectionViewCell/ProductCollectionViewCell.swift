//
//  ProductCollectionViewCell.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, ProductCell {

    // MARK: - Properties

    @IBOutlet weak var backgroundImageView: NetworkImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var verifiedImageView: UIImageView!
    
    private var model: ProductCellInput?
    
    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
    }

    // MARK: - Configure

    func configure(with model: ProductCellInput) {
        titleLabel.attributedText = model.title
        priceLabel.attributedText = model.price
        oldPriceLabel.attributedText = model.oldPrice
        backgroundImageView.setURL(model.imageURL)
        favoriteButton.isSelected = model.isFavorite
        verifiedImageView.isHidden = model.isVerified
        
        self.model = model
    }
    
    // MARK: - Actions

    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        guard let model = model else {
            return
        }
        
        if model.isFavorite {
            model.output?.productCell(self, didTapRemoveFromFavoritesAt: model.indexPath)
        } else {
            model.output?.productCell(self, didTapAddToFavoritesAt: model.indexPath)
        }
    }
}

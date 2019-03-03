//
//  ProductCellOutput.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/3/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation

protocol ProductCellOutput: class {
    func productCell(_ productCell: ProductCell,
                     didTapAddToFavoritesAt indexPath: IndexPath)
    
    func productCell(_ productCell: ProductCell,
                     didTapRemoveFromFavoritesAt indexPath: IndexPath)
}

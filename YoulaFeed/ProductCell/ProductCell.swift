//
//  ProductCell.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation

protocol ProductCell: class {
    func configure(with model: ProductCellInput)
}

//
//  Product.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation

struct Product {
    let identifier: Int
    let title: String
    let price: Int
    let oldPrice: Int?
    var isFavorite: Bool
    let isVerified: Bool
    let imageUrlString: String?
}

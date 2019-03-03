//
//  ProductCellInput.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation
import UIKit

protocol ProductCellInput {
    var title: NSAttributedString { get }
    var price: NSAttributedString { get }
    var oldPrice: NSAttributedString? { get }
    var isFavorite: Bool { get }
    var isVerified: Bool { get }
    var imageURL: URL? { get }
    
    var indexPath: IndexPath { get }
    var output: ProductCellOutput? { get }
}


final class AnyProductCellInput: ProductCellInput {
    
    // MARK: - Properties
    
    let title: NSAttributedString
    let price: NSAttributedString
    let oldPrice: NSAttributedString?
    let isFavorite: Bool
    let isVerified: Bool
    let imageURL: URL?
    
    let indexPath: IndexPath
    weak var output: ProductCellOutput?
    
    // MARK: - Initialization
    
    init(with product: Product, at indexPath: IndexPath, output: ProductCellOutput?) {
        title = NSAttributedString(string: product.title, attributes: Styles.title)
        price = NSAttributedString(string: "\(product.price) ₽", attributes: Styles.price)
        oldPrice = product.oldPrice.flatMap ({ NSAttributedString(string: "\($0) ₽", attributes: Styles.oldPrice) })
        isFavorite = product.isFavorite
        isVerified = product.isVerified
        imageURL = product.imageUrlString.flatMap ({ URL(string: $0) })
        
        self.indexPath = indexPath
        self.output = output
    }
    
    // MARK: - Styles
    
    private struct Styles {
        static let title: [NSAttributedString.Key: Any] = {
            return [
                .font:  UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor(white: 112/255, alpha: 1),
                ]
        }()
        
        static let price: [NSAttributedString.Key: Any] = {
            return [
                .font:  UIFont.systemFont(ofSize: 19, weight: .medium),
                .foregroundColor: UIColor(white: 51/255, alpha: 1),
                ]
        }()
        
        static let oldPrice: [NSAttributedString.Key: Any] = {
            return [
                .font:  UIFont.systemFont(ofSize: 14, weight: .medium),
                .foregroundColor: UIColor(white: 176/255, alpha: 1),
                .strikethroughStyle: 1
                ]
        }()
    }
}

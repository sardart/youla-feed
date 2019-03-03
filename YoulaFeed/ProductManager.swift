//
//  ProductManager.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation

final class ProductManager {
    
    // MARK: - Properties
    
    static let shared = ProductManager()
    private init() {}
    
    // MARK: - Public
    
    func loadProducts(completion: @escaping(([Product]?, Error?) -> Void)) {
        NetworkManager.shared.get("/products") { [weak self] (result, error) in
            let products = (result as? NSArray)?.compactMap ({ self?.productMapping($0) })
            
            DispatchQueue.main.async {
                completion(products, error)
            }
        }
    }
    
    // MARK: - Mapping
    
    private func productMapping(_ json: Any) -> Product? {
        guard let dict = json as? NSDictionary else {
            return nil
        }
        
        let identifier = dict["identifier"] as? Int
        let title = dict["title"] as? String
        let price = dict["price"] as? Int
        let oldPrice = dict["old_price"] as? Int
        let isFavorite = dict["is_favorite"] as? Bool
        let isVerified = dict["is_verified"] as? Bool
        let imageUrlString = dict["image_url"] as? String
        
        return Product(identifier: identifier ?? -1,
                       title: title ?? "",
                       price: price ?? 0,
                       oldPrice: oldPrice ?? 0,
                       isFavorite: isFavorite ?? false,
                       isVerified: isVerified ?? false,
                       imageUrlString: imageUrlString)
    }
}

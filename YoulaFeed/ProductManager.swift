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
                completion(self?.amplifiedList(of: products), error)
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
                       oldPrice: oldPrice,
                       isFavorite: isFavorite ?? false,
                       isVerified: isVerified ?? false,
                       imageUrlString: imageUrlString)
    }
}

private extension ProductManager {
    static let products: [Product] = [
        Product(identifier: 1,
                title: "Apple Watch 4",
                price: 400,
                oldPrice: 500,
                isFavorite: false,
                isVerified: true,
                imageUrlString: "https://pbs.twimg.com/media/DnFbBdYVsAAqnXN.jpg"),
        Product(identifier: 2,
                title: "iPhone X",
                price: 500,
                oldPrice: 750,
                isFavorite: false,
                isVerified: true,
                imageUrlString: "https://berryblog.ru/wp-content/uploads/2017/09/gettyimages-846148982.jpg"),
        Product(identifier: 3,
                title: "iPad Pro 2018",
                price: 600,
                oldPrice: 800,
                isFavorite: false,
                isVerified: true,
                imageUrlString: "https://www.iphones.ru/wp-content/uploads/2018/11/01FBA0D1-393D-4E9F-866C-F26F60722480.jpeg"),
        Product(identifier: 4,
                title: "MacBook Pro",
                price: 400,
                oldPrice: 500,
                isFavorite: false,
                isVerified: true,
                imageUrlString: "https://www.vladtime.ru/uploads/posts/2018-07/1531558828_24296312_jpg_770x380_q85_crop-0h.jpg")
    ]
    
    private func amplifiedList(of products: [Product]?) -> [Product] {
        let initialProducts: [Product]
        if let loadedProducts = products {
            initialProducts = loadedProducts
        } else {
            initialProducts = ProductManager.products
        }
        
        var amplifiedProductList = [Product]()
        for _ in 1...100 {
            amplifiedProductList.append(contentsOf: initialProducts)
        }
        
        return amplifiedProductList
    }
}

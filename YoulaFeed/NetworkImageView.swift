//
//  NetworkImageView.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import UIKit

final class NetworkImageView: UIImageView {
    
    // MARK: - Properties
    
    var url: URL?
    static var cache = [String: UIImage]()
    
    // MARK: - Public
    
    func setURL(_ url: URL?, placeholderImage: UIImage? = nil) {
        guard let url = url, url.absoluteString != self.url?.absoluteString else {
            return
        }
        
        self.url = url
        
        if let cachedImage = NetworkImageView.cache[url.absoluteString] {
            image = cachedImage
        } else {
            image = placeholderImage
            loadImage(from: url)
        }
    }
    
    // MARK: - Private
    
    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let loadedImage = UIImage(data: data) else {
                return
            }
            
            NetworkImageView.cache[url.absoluteString] = loadedImage
            
            DispatchQueue.main.async { [weak self] in
                self?.image = loadedImage
            }
        }
    }
}

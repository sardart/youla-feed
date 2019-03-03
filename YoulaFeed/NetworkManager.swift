//
//  NetworkManager.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/3/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Properties

    private let host = "http://127.0.0.1"
    private let port = 8080
    
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Public

    func get(_ path: String, completion: @escaping((Any?, Error?) -> Void)) {
        guard let url = URL(string: "\(host):\(port)\(path)") else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                completion(json, error)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}

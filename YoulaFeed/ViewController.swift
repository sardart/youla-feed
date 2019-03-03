//
//  ViewController.swift
//  YoulaFeed
//
//  Created by Artur Sardaryan on 3/2/19.
//  Copyright © 2019 Artur Sardaryan. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let numberOfItemsInRow: CGFloat = 2
    private let cellsOffset: CGFloat = 8
    private let cellsHeight: CGFloat = 240
    private let productCellIdentifier = "productCell"
    private var products = [Product]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        loadProducts()
    }
    
    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: productCellIdentifier)
    }
    
    // MARK: - Load Products
    
    private func loadProducts() {
        ProductManager.shared.loadProducts { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let products = result else {
                return
            }
            
            self?.products = products
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Collection View Data Source, Delegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier,
                                                            for: indexPath) as? ProductCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        
        let model = AnyProductCellInput(with: products[indexPath.row], at: indexPath, output: self)
        cell.configure(with: model)
        
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPadding = cellsOffset * (numberOfItemsInRow + 1)
        let availableWidth = view.frame.width - totalPadding
        let cellsWidth = availableWidth / numberOfItemsInRow
        
        return CGSize(width: cellsWidth, height: cellsHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: cellsOffset, bottom: 0, right: cellsOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellsOffset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellsOffset
    }
}

// MARK: - Product Cell Output

extension ViewController: ProductCellOutput {
    func productCell(_ productCell: ProductCell, didTapAddToFavoritesAt indexPath: IndexPath) {
        products[indexPath.row].isFavorite = true
        let model = AnyProductCellInput(with: products[indexPath.row], at: indexPath, output: self)
        
        productCell.configure(with: model)
    }
    
    func productCell(_ productCell: ProductCell, didTapRemoveFromFavoritesAt indexPath: IndexPath) {
        products[indexPath.row].isFavorite = false
        let model = AnyProductCellInput(with: products[indexPath.row], at: indexPath, output: self)

        productCell.configure(with: model)
    }
}

//
//  FavoritesViewController.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import UIKit

class FavouritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var favourites: [String] = {
        return UserDefaults.standard.value(forKey: kFavourites) as? [String] ?? []
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""

        self.title = "My Buddies"
        self.collectionView!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: HomeCell.cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellIdentifier, for: indexPath) as! HomeCell
        cell.configureForFaverites(URL.init(string: favourites[indexPath.item]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (collectionView.frame.size.width - 20)/2.0
        let height:CGFloat = 170
        
        return  CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

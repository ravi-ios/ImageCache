//
//  ViewController.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import UIKit

let kFavourites = "favorites"

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FavouritesDelegate {
    
    fileprivate var cats: [Cat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationbarAppearance()
        self.collectionView!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: HomeCell.cellIdentifier)
        getServiceData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.topItem?.title = "Kitty World"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateFavouritesBarButtonStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configureNavigationbarAppearance() {
        self.navigationItem.title = "Kitty World"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    fileprivate func getServiceData() {
        ProgressView.shared.show()
        
        ServiceManager.fetchServiceData { [weak self](data, error) in
            ProgressView.shared.hide()
            if let errorMessage = error?.localizedDescription {
                UIAlertController.showAlertWith(errorMessage, sender: self)
            } else if let data = data {
                self?.cats.append(contentsOf: data)
                self?.reloadCollectionView()
            }
        }
    }
    
    fileprivate func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellIdentifier, for: indexPath) as! HomeCell
        cell.configure(self.cats[indexPath.item], delegate: self)
        cell.favButton.tag = indexPath.item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == self.cats.count {
            self.getServiceData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (collectionView.frame.size.width - 25)
        let height:CGFloat = 350
        
        return  CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func willAddFavourite(_ sender: UIButton) {
        let cat = self.cats[sender.tag]
        guard let path = cat.imagePath?.absoluteString else { return }
        
        var favourites: [String]? = UserDefaults.standard.value(forKey: kFavourites) as? [String]
        if favourites == nil {
            favourites = []
        }
        
        if !sender.isSelected {
            if DataCache.saveDataToCache(path) == true {//Save selected image to a persistance storage
                favourites?.append(path) //Save selected image path in User defaults
                sender.isSelected = !sender.isSelected
            }
        } else { //Remove de selected image from persistance storage
            if DataCache.deleteDataFromDocumentsDirectory(path) == true {
                favourites = favourites?.filter(){$0 != path} //Remove de selected image path from User defaults
                sender.isSelected = !sender.isSelected
            }
        }
        UserDefaults.standard.set(favourites, forKey: kFavourites)
        UserDefaults.standard.synchronize()
        self.updateFavouritesBarButtonStatus()
    }
    
    fileprivate func updateFavouritesBarButtonStatus() {
        if let favourites = UserDefaults.standard.value(forKey: kFavourites) as? [String],favourites.count > 0  {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

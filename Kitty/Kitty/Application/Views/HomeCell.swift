//
//  HomeCell.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import UIKit

protocol FavouritesDelegate {
    func willAddFavourite(_ sender: UIButton)
}

class HomeCell: UICollectionViewCell {
    
    static let cellIdentifier = "Cell"
    fileprivate var delegate: FavouritesDelegate?
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCardEffect()
        self.favButton.tintColor = .red
    }
    
    func configure(_ cat: Cat?, delegate: FavouritesDelegate?) {
        self.delegate = delegate
        imageView.imageWithUrl(cat?.imagePath)
        
        let faverites: [String]? = UserDefaults.standard.value(forKey: kFavourites) as? [String]
        favButton.isSelected = faverites?.contains((cat?.imagePath?.absoluteString)!) ?? false
    }
    
    func configureForFaverites(_ imagePath: URL?) {
        imageView.imageWithUrl(imagePath)
        favButton.isHidden = true
        bottomView.isHidden = true
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        self.delegate?.willAddFavourite(sender)
    }
    
    fileprivate func applyCardEffect() {
        self.cardView.backgroundColor = .clear
        self.cardView.alpha = 1.0
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 25.0
        self.cardView.layer.borderColor = UIColor.gray.cgColor
        self.cardView.layer.borderWidth = 1.0
        self.cardView.layer.shadowOffset = CGSize.zero
        self.cardView.layer.shadowRadius = 1.0
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.shadowOpacity = 1.0
        
        self.imageView.layer.cornerRadius = 25.0
        self.imageView.clipsToBounds = true
        
        self.bottomView.layer.cornerRadius = 5.0
        self.bottomView.clipsToBounds = true
        
        self.setNeedsLayout()
        self.layoutSubviews()
    }
}

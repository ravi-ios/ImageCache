//
//  UIImageView.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    // Activity indicator for every image
    fileprivate func removeIndicator(_ indicator: UIActivityIndicatorView?) {
        DispatchQueue.main.async {
            indicator?.stopAnimating()
            indicator?.removeFromSuperview()
        }
    }
    
    //Get images from Cache/ Server
    func imageWithUrl(_ imageUrl: URL?, mode: UIViewContentMode = .scaleAspectFit) {
        self.image = UIImage(named: "cat") // Default place holder image
        guard let url = imageUrl else {return}
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView.init(frame: self.frame)
        
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = .black
        
        indicator.translatesAutoresizingMaskIntoConstraints = false

        let constraintX = NSLayoutConstraint.init(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let constraintY = NSLayoutConstraint.init(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        
        self.addSubview(indicator)
        self.bringSubview(toFront: indicator)
        indicator.startAnimating()
        
        self.addConstraints([constraintX, constraintY])
        self.layoutIfNeeded()
        
        //Get images from Cache
        if let image = DataCache.fetchDataFromCache(url.absoluteString) {
            self.image = image
            self.removeIndicator(indicator)
            return
        }
        
        // If not, then go with server data
        ServiceManager.fecthImage(url) { [weak self] (data, error) in
            DispatchQueue.main.async {
                self?.removeIndicator(indicator)
            }
            
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DataCache.saveDataToLocalCache(image, path: url.absoluteString)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

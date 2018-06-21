//
//  DataCache.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation
import UIKit

// Local Cache
let imageCache = NSCache<AnyObject, AnyObject>()

struct DataCache {
    
    static func saveDataToLocalCache(_ image: UIImage, path: String) {
        imageCache.setObject(image, forKey: path as AnyObject) // Push to local Cache
    }
    
    static func saveDataToCache(_ path: String) -> Bool {
        // I really don't wanna save same image twice at any case
        if let _ = DataCache.fetchDataFromDocumentsDirectory(path) {
            return false
        }
        
        // Get image from local cache and make it as a persistance storage
        guard let image = DataCache.fetchDataFromLocalCache(path) else {return false }
        
        guard let url = DataCache.urlForDocumentsDirectory(path) else { return false }
        
        do {
            try UIImagePNGRepresentation(image)?.write(to: url)
        }
        catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    static func fetchDataFromCache(_ path: String) -> UIImage? {
        
        if let data = DataCache.fetchDataFromLocalCache(path) {
            return data // From local Cache
        }
        
        if let data = DataCache.fetchDataFromDocumentsDirectory(path) {
            return data // From persistance store
        }
        return nil
    }
    
    static func fetchDataFromLocalCache(_ path: String) -> UIImage? {
        return imageCache.object(forKey: path as AnyObject) as? UIImage
    }
    
    static func fetchDataFromDocumentsDirectory(_ path: String) -> UIImage? {
        guard let url = DataCache.urlForDocumentsDirectory(path) else { return nil }
        return UIImage.init(contentsOfFile: url.path)
    }
    
    static func deleteDataFromDocumentsDirectory(_ path: String) -> Bool? {
        guard let url = DataCache.urlForDocumentsDirectory(path) else { return false }
        
        do {
            try FileManager.default.removeItem(at: url)
        }
        catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    static fileprivate func urlForDocumentsDirectory(_ path: String) -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        guard let imagePath = path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        return directory.appendingPathComponent(imagePath)
    }
}

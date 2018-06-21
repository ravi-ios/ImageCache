//
//  Cat.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation
import UIKit

struct Cat {
    
    static let kUrl = "url"
    static let kId  = "id"
    
    var id: String? //As of now unused variable
    var imagePath: URL?
    
    init(_ id: String?, imagePath: String?) {
        self.id = id
        if let path = imagePath {
            self.imagePath = URL.init(string: path)
        }
    }
}

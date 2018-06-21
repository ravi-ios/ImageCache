//
//  Request.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation

struct Request {
    
    enum imageFormat: String {
        case png = "png"
        case jpg = "jpg"
    }
    
    enum responseFormat: String {
        case xml = "xml"
    }

    enum imageSize: String {
        case small = "small" // 250x
        case medium = "med"  // 500x
        case large = "full"  // Original Size
    }
    
    static let baseUrl = "http://thecatapi.com/"
    static let urlPath = "api/images/get"
    static let apiKey  = "MzIyOTkx"
    
    static let kFormat = "format"
    static let kApi    = "api_key"
    static let kType   = "type"
    static let kSize   = "size"
    
    static let kResultsPerPage = "results_per_page"
    
//    http://thecatapi.com/api/images/get?format=xml&results_per_page=20

    var url: URL {
        get {
            let urlString = Request.baseUrl + Request.urlPath + "?"
                + Request.kApi + "=" + Request.apiKey
                + "&" + Request.kFormat + "=" + responseFormat.xml.rawValue
                + "&" + Request.kType + "=" + imageFormat.png.rawValue
                + "&" + Request.kSize + "=" + imageSize.small.rawValue
                + "&" + Request.kResultsPerPage + "=" + "100"
            
            return URL(string: urlString)!
        }
    }
}

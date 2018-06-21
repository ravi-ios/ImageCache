//
//  XMLParser.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation

class Parser: NSObject, XMLParserDelegate {
    
    static fileprivate let kImage = "image"
    
    fileprivate var element = ""
    
    fileprivate var imageId = "" {
        didSet {
            imageId = imageId.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    fileprivate var imagePath = "" {
        didSet {
            imagePath = imagePath.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    fileprivate var completionHandler:(([Cat]?, String?) -> Void)?
    
    fileprivate var cats: [Cat]? = []
    
    func parse(_ data: Data?, with completionHandler:(([Cat]?, String?) -> Void)?) {
        self.completionHandler = completionHandler
        
        guard let data = data else {
            self.completionHandler?(nil, "nil can not be parsed")
            return
        }
        
        let rParser = XMLParser.init(data: data)
        rParser.delegate = self
        rParser.parse()
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch self.element {
        case Cat.kId: imageId += string
        case Cat.kUrl: imagePath += string
        default:break
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.element = elementName
        if self.element == Parser.kImage { // Safe guard from older data
            imageId = ""
            imagePath = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == Parser.kImage {
            let cat = Cat.init(imageId, imagePath: imagePath)
            self.cats?.append(cat) //Finish the cat models one by one
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.completionHandler?(cats, nil) // Parsing hasbeen finished
    }
}

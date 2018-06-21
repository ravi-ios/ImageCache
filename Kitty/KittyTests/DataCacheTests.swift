//
//  DataCacheTests.swift
//  KittyTests
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import XCTest
@testable import Kitty

class DataCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {

    }
    
    func testPerformanceExample() {
        self.measure {

        }
    }
    
    func url(forResource fileName: String, withExtension ext: String) -> URL {
        let bundle = Bundle(for: DataCacheTests.self)
        return bundle.url(forResource: fileName, withExtension: ext)!
    }
    
    func testImageFromLocalCache() {
        
        let url = self.url(forResource:"Sample", withExtension:"png")
        
        XCTAssertNotNil(url)
        
        guard let image = UIImage.init(contentsOfFile: url.path) else {
            XCTFail("Image should not be nil")
            return
        }
        //Save to NSCache
        DataCache.saveDataToLocalCache(image, path: url.path)
        
        //Get from NSCache
        let response = DataCache.fetchDataFromLocalCache(url.path)
        XCTAssertNotNil(response)
    }
    
    func testImageSavedInCache() {
        
        let url = self.url(forResource:"Sample", withExtension:"png")
        
        XCTAssertNotNil(url)
        
        guard let image = UIImage.init(contentsOfFile: url.path) else {
            XCTFail("Image should not be nil")
            return
        }
        //Save to NSCache
        DataCache.saveDataToLocalCache(image, path: url.path)
        
        //Save to Cache
        let status = DataCache.saveDataToCache("Sample.png")
        XCTAssertNotNil(status)
        XCTAssertFalse(status)
    }
    
    func testImageDeletionFromCache() {
        
        let url = self.url(forResource:"Sample", withExtension:"png")
        
        XCTAssertNotNil(url)
        
        guard let image = UIImage.init(contentsOfFile: url.path) else {
            XCTFail("Image should not be nil")
            return
        }
        //Save to NSCache
        DataCache.saveDataToLocalCache(image, path: url.path)
        
        //Save to Cache
        var status = DataCache.saveDataToCache("Sample.png")
        XCTAssertNotNil(status)
        XCTAssertFalse(status)
        
        //Save to Cache
        status = DataCache.deleteDataFromDocumentsDirectory("Sample.png")!
        XCTAssertNotNil(status)
        XCTAssertFalse(status)
    }
}

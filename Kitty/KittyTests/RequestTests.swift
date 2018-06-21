//
//  RequestTests.swift
//  KittyTests
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import XCTest
@testable import Kitty

class RequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRequestUrl() {
        let request = Request()
        
        XCTAssertNotNil(request.url, "Resource URL should not be nil")
        
        let urlString = request.url.absoluteString
        let validUrlString = "http://thecatapi.com/api/images/get?api_key=MzIyOTkx&format=xml&type=png&size=small&results_per_page=100"
        
        XCTAssertEqual(urlString, validUrlString, "Incorrect service with path")
    }
}

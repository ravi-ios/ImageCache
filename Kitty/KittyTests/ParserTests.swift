//
//  ParserTests.swift
//  KittyTests
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import XCTest
@testable import Kitty

class ParserTests: XCTestCase {
    
    var parser: Parser?
    var sampleFileUrl: URL?
    let timeout: TimeInterval = 30.0
    
    override func setUp() {
        super.setUp()
        parser = Parser()
        sampleFileUrl = Bundle(for: type(of: self)).url(forResource: "Sample", withExtension: "xml")
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
    
    func testFileParsing() {
        
        var fileData: Data?
        var response: [Cat]?
        
        if let url = sampleFileUrl, let data = try? Data(contentsOf: url) {
            fileData = data
        } else {
            XCTFail("data should exist for contents of url")
        }
        
        let expectation = self.expectation(description: "Parser should parse the data")
        
        parser?.parse(fileData, with: { (parsedContent, errorMessage) in
            XCTAssertTrue((errorMessage == nil))
            response = parsedContent
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: timeout) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error.localizedDescription)")
            }
        }
        
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.count)
        XCTAssertTrue(response?.count == 100, "Unexpected parsed objects count")
    }
}

//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Sanad Barjawi on 8/5/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {
    private var service: ArticlesService!
    
    override func setUp() {
        super.setUp()
        service = ArticlesService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        
        service = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testArticles() {
        var results: Bool?
        let exp = expectation(description: "testArticles is successful")

        testArticles(from: .aDayAgo) { (res) in
            results = res
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(results, true)
        }
    }
    
    func testArticles(from: ArticlesService.MostViewedMarker, completion: @escaping(Bool) -> Void) {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        service.mostViewed(marker: .aDayAgo) { (result) in
            switch result {
            case .failure(_):
             completion(false)
                
            case .success(_):
              completion(true)
            }
        }
        
    }
}

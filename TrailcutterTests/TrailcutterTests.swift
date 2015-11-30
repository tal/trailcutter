//
//  TrailcutterTests.swift
//  TrailcutterTests
//
//  Created by Tal Atlas on 11/12/15.
//  Copyright © 2015 Range. All rights reserved.
//

import XCTest
@testable import Trailcutter

let routes: [Routeable.Type] = [
    SearchRoute.self,
    NoMatch.self,
]

let failure: Routeable? -> Bool = { (result) -> Bool in
    var success = true
    
    if let _ = result {
        success = false
    }
    
    return success
}

let isSearchRoute: Routeable? -> Bool = { (result) -> Bool in
    var success = false
    
    if let _ = result as? SearchRoute {
        success = true
    }
    
    return success
}

class TrailcutterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var tests: [RouteTestExample] = [
        RouteTestExample(
            urlS:  "https://foo.mysite.net/search/term2",
            sucessCheck: isSearchRoute,
            routes: routes
        ),
        RouteTestExample(
            urlS: "https://what.com/search/term2",
            sucessCheck: failure,
            routes: routes
        ),
        RouteTestExample(
            urlS: "https://foo.mysite.net/omg/term2",
            sucessCheck: failure,
            routes: routes
        ),
        RouteTestExample(
            urlS: "https://foo.mysite.net/search/",
            sucessCheck: failure,
            routes: routes
        ),
        RouteTestExample(
            urlS: "https://foo.mysite.net/search",
            sucessCheck: failure,
            routes: routes
        ),
        RouteTestExample(
            urlS: "https://foo.mysite.net/no-match",
            sucessCheck: failure,
            routes: routes
        ),
    ]
    
    func testAll() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        for test in tests {
            XCTAssert(test.doesMatch)
        }
    }

    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}

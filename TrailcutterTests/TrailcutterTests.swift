//
//  TrailcutterTests.swift
//  TrailcutterTests
//
//  Created by Tal Atlas on 11/12/15.
//  Copyright © 2015 Range. All rights reserved.
//

import XCTest
@testable import Trailcutter

private let routes: [Routeable.Type] = [
    SearchRoute.self,
    PostRoute.self,
    NoMatch.self,
]

private let failure: Routeable? -> Bool = { (result) -> Bool in
    var success = true
    
    if result != nil {
        success = false
    }
    
    return success
}

private let isSearchRoute: Routeable? -> Bool = { (result) -> Bool in
    var success = false
    
    if result is SearchRoute {
        success = true
    } else {
        XCTAssert(false, "result not correct type")
    }
    
    return success
}

private let isPostRoute: Routeable? -> Bool = { (result) -> Bool in
    var success = false
    
    if result is PostRoute {
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
    
    var tests = [
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
        RouteTestExample(
            urlS: "https://foo.mysite.com/post/123",
            sucessCheck: isPostRoute,
            routes: routes
        ),
        RouteTestExample(
            urlS:  "https://foo.mysite.net/search/termOMG",
            sucessCheck: { (result) -> Bool in
                var success = false
                
                if let result = result as? SearchRoute {
                    if let foo = result.match.pathParams?["term"] {
                        success = foo == "termOMG"
                    } else {
                        XCTAssert(false, "no param for key")
                    }
                } else {
                    XCTAssert(false, "result not correct type")
                }
                
                return success
            },
            routes: routes
        ),
        RouteTestExample(
            urlS:  "https://foo.mysite.net/search/termOMG?key=myvalue",
            sucessCheck: { (result) -> Bool in
                var success = false
                
                if let result = result as? SearchRoute {
                    if let foo = result.match.queryParams?["key"] {
                        success = foo == "myvalue"
                    } else {
                        XCTAssert(false, "no param for key")
                    }
                } else {
                    XCTAssert(false, "result not correct type")
                }
                
                return success
            },
            routes: routes
        ),
    ]
    
    func testAll() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        for test in tests {
            XCTAssert(test.runTest(), "Test failed: \(test.urlS)")
        }
    }
    
    func testEmptyPathBuild() {
        let str = SearchRoute.pathFromParams([:])
        
        XCTAssertEqual("/search/:term", str)
    }
    
    func testCompletePathBuild() {
        let str = SearchRoute.pathFromParams(["term": "omgItsATerm"])
        
        XCTAssertEqual("/search/omgItsATerm", str)
    }
    
    func testExcessPathBuild() {
        let str = SearchRoute.pathFromParams(["term": "omgItsATerm", "two": "fooz ball"])
        
        XCTAssertEqual("/search/omgItsATerm?two=fooz%20ball", str)
    }
    
    func testFullUri() {
        let str = PostRoute.uriFromParams(["id": "123"])
        
        XCTAssertEqual("https://*.mysite.com/post/123", str)
    }
    
    func testFullUriWithHost() {
        let str = PostRoute.uriFromParams(["id": "123"], overrideHost: "foo.mysite.com")
        
        XCTAssertEqual("https://foo.mysite.com/post/123", str)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}

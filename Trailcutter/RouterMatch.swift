//
//  RouterMatch.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public struct RouterMatch {
    let url: NSURL
    
    public var _propertyStore = [String: AnyObject?]()
    
    public var _wasMatched = false
    
    public var queryParams: [String: String]? {
        return url.queryDict
    }
    
    init(url: NSURL) {
        self.url = url
    }
}

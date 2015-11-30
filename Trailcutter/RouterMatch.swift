//
//  RouterMatch.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public struct RouterMatch {
    let URL: NSURL
    var pathMatch:[String: String]? = nil
    var wasMatched = false
    
    subscript (key: String) -> String? {
        if let val = pathMatch?[key] {
            return val
        }
        
        if let val = URL.queryDict?[key] {
            return val
        }
        
        return nil
    }
}

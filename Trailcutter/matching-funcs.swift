//
//  matching-funcs.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

func stringToken(str: String) -> String? {
    if str.substringToIndex(1) == ":" {
        return str.substringFromIndex(1)
    } else {
        return nil
    }
}

func matchRouteToString(route route: String, path: String) -> [String: String]? {
    let routeCharSet = route.characters.split("/")
    let pathCharSet  = path.characters.split("/")
    
    if routeCharSet.count != pathCharSet.count {
        return nil
    }
    
    let pathSet:[String]  = pathCharSet.map(String.init)
    let routeSet:[String] = routeCharSet.map(String.init)
    
    var match = [String: String]()
    
    for (i, pathItem) in pathSet.enumerate() {
        let routeItem = routeSet[i]
        
        if let token = stringToken(routeItem) {
            match[token] = pathItem
        } else {
            if pathItem != routeItem {
                return nil
            }
        }
    }
    
    return match
}

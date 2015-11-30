//
//  PathRouteable.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public protocol PathRouteable: Routeable {
    static var path: String { get }
}

func matchPathRouteable(Route: Routeable.Type)(_ match: RouterMatch?) -> RouterMatch? {
    guard var match = match else { return nil }
    
    if let PathRoute = Route as? PathRouteable.Type {
        if let path = match.url.path {
            match.pathMatch = matchRouteToString(route: PathRoute.path, path: path)
        }
        
        if match.pathMatch == nil {
            return nil
        } else {
            match.wasMatched = true
        }
    }
    
    return match
}

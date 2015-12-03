//
//  SchemeRouteable.swift
//  Trailcutter
//
//  Created by Tal Atlas on 12/3/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public protocol SchemeRouteable: Routeable {
    static var scheme: String { get }
}

func matchSchemeRouteable(Route: Routeable.Type)(_ match: RouterMatch?) -> RouterMatch? {
    guard var match = match else { return nil }
    
    if let SchemeRoute = Route as? SchemeRouteable.Type {
        
        if SchemeRoute.scheme == match.url.scheme {
            match._wasMatched = true
        } else {
            return nil
        }
    }
    
    return match
}

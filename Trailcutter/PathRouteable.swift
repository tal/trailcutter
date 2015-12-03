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

private let pathDataString = "path_data"

public extension RouterMatch {
    var pathParams: [String: String]? {
        return _propertyStore[pathDataString] as? [String: String]
    }
}

public extension PathRouteable {
    public static func pathFromParams(params: [String: String]) -> String {
        var mutableParams = params
        var mutablePath = path
        
        for (key, value) in params {
            let replace = ":\(key)"
            
            if mutablePath.containsString(replace) {
                mutablePath = mutablePath.stringByReplacingOccurrencesOfString(replace, withString: value)
                mutableParams.removeValueForKey(key)
            }
        }
        
        if mutableParams.count > 0 {
            mutablePath += "?\(mutableParams.toQueryString())"
        }
        
        return mutablePath
    }
}

func matchPathRouteable(Route: Routeable.Type)(_ match: RouterMatch?) -> RouterMatch? {
    guard var match = match else { return nil }
    
    if let PathRoute = Route as? PathRouteable.Type {

        if let path = match.url.path {
            match._propertyStore[pathDataString] = matchRouteToString(route: PathRoute.path, path: path)
        }
        
        if match._propertyStore[pathDataString] == nil {
            return nil
        } else {
            match._wasMatched = true
        }
    }
    
    return match
}

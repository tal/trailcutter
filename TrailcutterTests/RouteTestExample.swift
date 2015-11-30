//
//  RouteTestExample.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/29/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Trailcutter

struct RouteTestExample {
    let urlS: String
    
    var url: NSURL {
        guard let url = NSURL(string: urlS) else { fatalError("") }
        return url
    }
    
    let sucessCheck: Routeable? -> Bool
    
    let routes: [Routeable.Type]
    
    var routeSet: RouteSet {
        return RouteSet(routes: routes)
    }
    
    var matchResult: Routeable? {
        return routeSet.match(url)
    }
    
    var doesMatch: Bool {
        return sucessCheck(matchResult)
    }

}

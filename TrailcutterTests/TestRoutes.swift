//
//  TestRoutes.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/29/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Trailcutter

struct SearchRoute: PathRouteable, HostRouteable {
    static let host = "*.mysite.net"
    static let path = "/search/:term"
    
    let match: RouterMatch
    
    init(routerMatch: RouterMatch) {
        match = routerMatch
    }
}

struct NoMatch: Routeable {
    static let host = "*.mysite.net"
    static let path = "/no-match"
    
    let match: RouterMatch
    
    init(routerMatch: RouterMatch) {
        match = routerMatch
    }
}


struct PostRoute: URIRouteable {
    static let uri = "https://*.mysite.com/post/:id"
    
    let match: RouterMatch
    
    init(routerMatch: RouterMatch) {
        match = routerMatch
    }
}

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
    
    init(routerMatch:RouterMatch) {
        
    }
}

struct NoMatch: Routeable {
    static let host = "*.mysite.net"
    static let path = "/no-match"
    
    init(routerMatch:RouterMatch) {
        
    }
}

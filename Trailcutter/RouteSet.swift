//
//  RouteSet.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public typealias RouteableMatchingFunc = Routeable.Type -> RouterMatch? -> RouterMatch?

private let defaultMatchers = [matchPathRouteable, matchHostRouteable, matchWasMatched]

public struct RouteSet {
    private let routes: [Routeable.Type]
    private let matchers: [RouteableMatchingFunc]
    
    public init(routes: [Routeable.Type], matchers: [RouteableMatchingFunc] = defaultMatchers) {
        self.routes = routes
        self.matchers = matchers
    }
    
    public init(routes: [Routeable.Type], additionalMatchers: [RouteableMatchingFunc]) {
        let matchers = defaultMatchers + additionalMatchers
        
        self.init(routes: routes, matchers: matchers)
    }
    
    private func matchRoute(Route: Routeable.Type, match: RouterMatch?) -> RouterMatch? {
        let curriedFuncs = matchers.map { $0(Route) }
        
        return curriedFuncs.reduce(match) { $1($0) }
    }
    
    public func match(url: NSURL) -> Routeable? {
        
        var routeInstance:Routeable? = nil
        
        for Route in routes {
            let match = RouterMatch(URL: url, pathMatch: nil, wasMatched: false)
            
            if let successfulMatch = matchRoute(Route, match: match) {
                routeInstance = Route.init(routerMatch: successfulMatch)
                break
            }
        }
        
        return routeInstance
    }
}

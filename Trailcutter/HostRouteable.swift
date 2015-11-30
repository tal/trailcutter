//
//  HostRouteable.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public protocol HostRouteable: Routeable {
    static var host: String { get }
}

private func isSuffix(host: String) -> Bool {
    return host[0] == "*"
}

private func hostMatchesSuffix(suffix: String, host: String) -> Bool {
    let suffixWithoutAsterix = suffix.substringFromIndex(1)
    
    return host.hasSuffix(suffixWithoutAsterix)
}

func matchHostRouteable(Route: Routeable.Type)(_ match: RouterMatch?) -> RouterMatch? {
    guard var match = match else { return nil }
    
    if let HostRoute = Route as? HostRouteable.Type {
        
        guard let urlHost = match.URL.host else { return nil }
        
        if isSuffix(HostRoute.host) {
            if hostMatchesSuffix(HostRoute.host, host: urlHost) {
                match.wasMatched = true
            } else {
                return nil
            }
        } else if HostRoute.host == urlHost {
            match.wasMatched = true
        } else {
            return nil
        }
    }
    
    return match
}

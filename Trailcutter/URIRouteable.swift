//
//  URIRouteable.swift
//  Trailcutter
//
//  Created by Tal Atlas on 12/3/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

public protocol URIRouteable: HostRouteable, PathRouteable, SchemeRouteable {
    static var uri: String { get }
}

public extension URIRouteable {
    public static var path: String {
        let url = NSURL(string: uri)
        
        return url!.path!
    }
    
    public static var host: String {
        let url = NSURL(string: uri)
        
        return url!.host!
    }
    
    public static var scheme: String {
        let url = NSURL(string: uri)
        
        return url!.scheme
    }
    
    public static func uriFromParams(params: [String: String], overrideHost: String? = nil) -> String {
        let path = pathFromParams(params)
        let host = overrideHost ?? self.host
        
        return "\(scheme)://\(host)\(path)"
    }
}

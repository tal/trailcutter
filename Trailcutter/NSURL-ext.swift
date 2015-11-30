//
//  NSURL-ext.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

extension NSURL {
    var queryDict: [String: String]? {
        guard let query = query else { return nil }
        
        var dict = [String: String]()
        
        let pairs = query.characters.split("&").map(String.init)
        
        for pair in pairs {
            let kv = pair.characters.split("=").map(String.init)
            
            if let key = kv[safe: 0] {
                dict[key] = kv[safe: 1] ?? ""
            }
        }
        
        return dict
    }
}

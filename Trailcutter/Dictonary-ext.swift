//
//  Dictonary-ext.swift
//  Trailcutter
//
//  Created by Tal Atlas on 12/3/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

extension Dictionary where Key: StringLiteralConvertible, Value: StringLiteralConvertible {
    func toQueryString() -> String {
        let strings = flatMap { (key, value) -> (String, String)? in
            if let key = key as? String, value = value as? String {
                return (key, value)
            } else {
                return nil
            }
        }
        
        let queryItems = strings.map { NSURLQueryItem(name:$0, value:$1) }
        let components = NSURLComponents()
        components.queryItems = queryItems
        return components.percentEncodedQuery ?? ""
    }
}

//
//  ensure-matching.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

func matchWasMatched(Route: Routeable.Type)(_ match: RouterMatch?) -> RouterMatch? {
    guard let match = match else { return nil }
    
    return match.wasMatched ? match : nil
}

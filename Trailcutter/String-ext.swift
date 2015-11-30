//
//  String-ext.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

extension String {
    
    func substringToIndex(from: Int) -> String {
        return substringToIndex(startIndex.advancedBy(from))
    }
    
    func substringFromIndex(from: Int) -> String {
        let range = Range(start: startIndex.advancedBy(from), end: endIndex)
        
        return substringWithRange(range)
    }
    
    subscript (i: Int) -> Character {
        return self[startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}

//
//  Array-ext.swift
//  Trailcutter
//
//  Created by Tal Atlas on 11/27/15.
//  Copyright © 2015 Range. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    subscript (safeOrLast index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : self.last
        }
        set(val) {
            guard let val = val else { return }
            
            if index > capacity {
                append(val)
            } else {
                insert(val, atIndex: index)
            }
        }
    }
}

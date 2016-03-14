//
//  Int+Beats.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation

extension Int {
    var beats: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.second = Int(Float(self) * 86.4) // Approximated
        return dateComponents
    }
}

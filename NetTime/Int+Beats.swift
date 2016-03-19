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
        let totalBeats: Float = Float(self) * 86.4
        dateComponents.second = Int(floor(totalBeats))
        dateComponents.nanosecond = Int((totalBeats - floor(totalBeats)) * 10.0) * 100 * 1000 * 1000
        return dateComponents
    }
}

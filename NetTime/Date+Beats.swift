//
//  NSDate+Beats.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation
import SwiftDate

extension Date {
    var beats: Float {
        let midnight = self.inGMTRegion().startOf(component: .day) - 60.minutes

        let seconds = self.timeIntervalSince(midnight.absoluteDate)
        return fmod(Float((seconds / 86400.0) * 1000.0), 1000.0)
    }

    var nearestBeat: Int {
        return Int(floor(self.beats))
    }
}

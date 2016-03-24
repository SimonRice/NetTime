//
//  NSDate+Beats.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation
import SwiftDate

extension NSDate {
    var beats: Float {
        let gmtRegion = Region(timeZoneName: TimeZoneName.Gmt)
        let midnight = self.startOf(.Day, inRegion: gmtRegion) - 60.minutes

        let seconds = self.timeIntervalSinceDate(midnight)
        return fmod(Float((seconds / 86400.0) * 1000.0), 1000.0)
    }

    var nearestBeat: Int {
        return Int(floor(self.beats))
    }
}

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
        let bmtz = Region(timeZoneName: TimeZoneName(rawValue: "Europe/Zurich"))
        let bmtDate = DateInRegion(absoluteTime: self, region: bmtz)
        let midnight = bmtDate.startOf(.Day)

        let seconds = bmtDate.absoluteTime.timeIntervalSinceDate(midnight.absoluteTime)
        return Float((seconds / 86400.0) * 1000.0)
    }
}

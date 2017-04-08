//
//  NSDate+Beats.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation

extension Date {
    var beats: Float {
        var components = Calendar.current
            .dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: self)
        components.timeZone = TimeZone(secondsFromGMT: 60 * 60) // BMT == UTC+1
        components.hour = 0
        components.minute = 0
        components.second = 0

        guard let midnight = Calendar.current.date(from: components) else { return 0 }

        let seconds = self.timeIntervalSince(midnight)
        return fmod(Float((seconds / 86400.0) * 1000.0), 1000.0)
    }

    var nearestBeat: Int {
        return Int(floor(self.beats))
    }
}

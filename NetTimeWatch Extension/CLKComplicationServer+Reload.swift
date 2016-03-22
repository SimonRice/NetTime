//
//  CLKComplicationServer+Reload.swift
//  NetTime
//
//  Created by Simon Rice on 22/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import ClockKit

extension CLKComplicationServer {
    func reloadActiveComplications() {
        if let activeComplications = self.activeComplications {
            activeComplications.forEach({ self.reloadTimelineForComplication($0) })
        }
    }
}

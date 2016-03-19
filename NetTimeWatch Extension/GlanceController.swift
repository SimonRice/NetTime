//
//  GlanceController.swift
//  NetTimeWatch Extension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import ClockKit
import Foundation
import WatchKit

class GlanceController: WKInterfaceController {
    @IBOutlet var beatsLabel: WKInterfaceLabel!

    override func willActivate() {
        super.willActivate()

        let complicationServer = CLKComplicationServer.sharedInstance()
        complicationServer.activeComplications
            .forEach({ complicationServer.reloadTimelineForComplication($0) })

        if let label = self.beatsLabel {
            label.setText(String(format: "@%03d \n Beats", Int(NSDate().beats)))
        }
    }
}

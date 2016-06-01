//
//  MainInterfaceController.swift
//  NetTime
//
//  Created by Simon Rice on 01/06/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import ClockKit
import Foundation
import WatchKit

class MainInterfaceController: WKInterfaceController {
    private func refreshComplications() {
        CLKComplicationServer.sharedInstance().reloadActiveComplications()
    }

    override func willActivate() {
        super.willActivate()
        self.refreshComplications()
    }

    override func didDeactivate() {
        super.didDeactivate()
        self.refreshComplications()
    }
}

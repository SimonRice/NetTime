//
//  InterfaceController.swift
//  NetTimeWatch Extension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import ClockKit
import RxSwift
import Foundation
import WatchKit

class InterfaceController: WKInterfaceController {
    @IBOutlet var beatsLabel: WKInterfaceLabel!
    private var subscription: Disposable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()

        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications {
            complicationServer.reloadTimelineForComplication(complication)
        }

        self.subscription = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.setText(String(format: "@%05.1f \n Beats", NSDate().beats))
                }
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
        self.subscription.dispose()

        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications {
            complicationServer.reloadTimelineForComplication(complication)
        }
    }
}

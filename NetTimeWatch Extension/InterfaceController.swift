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

    private func refreshComplications() {
        CLKComplicationServer.sharedInstance().reloadActiveComplications()
    }

    override func willActivate() {
        super.willActivate()
        self.refreshComplications()

//        // Test Mode only
//        if let label = self.beatsLabel {
//            label.setText("@423 \n .beats")
//        }

        self.subscription = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.setText(String(format: "@%05.1f \n .beats",
                        floor(NSDate().beats * 10) / 10.0))
                }
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
        if let subscription = self.subscription {
            subscription.dispose()
        }

        self.refreshComplications()
    }
}

//
//  ViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import RxSwift
import SwiftDate
import UIKit

class NowViewController: UIViewController {
    @IBOutlet private weak var beatsLabel: UILabel!
    private var subscription: Disposable?

    private var date: NSDate {
        if NSProcessInfo.processInfo().arguments.contains("TEST_MODE") {
            let region = Region(timeZoneName: TimeZoneName.EuropeZurich)
            return DateInRegion(year: 2016, month: 1, day: 1,
                                hour: 9, minute: 41, region: region).absoluteTime
        }

        return NSDate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription = Observable<Int>.interval(0.01, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.text = String(format: "@%06.2f", self.date.beats)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        if let subscription = self.subscription {
            subscription.dispose()
        }
    }
}

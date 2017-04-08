//
//  ViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import RxSwift
import StoreKit
import UIKit

class NowViewController: UIViewController {
    @IBOutlet fileprivate weak var beatsLabel: UILabel!
    fileprivate var subscription: Disposable?

    fileprivate var date: Date {
        if ProcessInfo.processInfo.arguments.contains("TEST_MODE") {
            var components = DateComponents()
            components.timeZone = TimeZone(identifier: "Europe/Zurich")
            components.calendar = .current
            components.year = 2016
            components.month = 1
            components.day = 1
            components.hour = 9
            components.minute = 41

            guard let date = components.date else {
                fatalError("Unable to create date for testing")
            }

            return date
        }

        return Date()
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

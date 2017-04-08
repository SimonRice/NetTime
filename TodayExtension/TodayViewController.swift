//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import NotificationCenter
import RxSwift
import UIKit

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var beatsLabel: UILabel!
    fileprivate var subscription: Disposable!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription = Observable<Int>.interval(0.01, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.text = String(format: "@%06.2f beats", Date().beats)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.subscription.dispose()
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }

    // swiftlint:disable:next line_length
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

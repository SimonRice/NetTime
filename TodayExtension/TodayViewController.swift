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
    private var subscription: Disposable!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription = Observable<Int>.interval(0.01, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.text = String(format: "@%06.2f beats", NSDate().beats)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.subscription.dispose()
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
    }

    // swiftlint:disable:next line_length
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
}

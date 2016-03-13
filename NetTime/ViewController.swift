//
//  ViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var beatsLabel: UILabel!
    private var subscription: Disposable!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription = Observable<Int>.interval(0.01, scheduler: MainScheduler.instance)
            .subscribe { _ in
                if let label = self.beatsLabel {
                    label.text = String(format: "@%06.2f", NSDate().beats)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.subscription.dispose()
    }
}


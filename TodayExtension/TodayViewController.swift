//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import NotificationCenter
import RxCocoa
import RxSwift
import UIKit

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var beatsLabel: UILabel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let observable = Observable<Int>.interval(0.01, scheduler: MainScheduler.instance)

        observable.map({ _ in String(format: "@%06.2f beats", Date().beats) })
            .bind(to: beatsLabel.rx.text)
            .disposed(by: bag)
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }

    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return .zero
    }
}
